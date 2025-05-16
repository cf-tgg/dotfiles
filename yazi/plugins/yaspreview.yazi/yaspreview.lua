-- yaspreview.lua

local posix = require('posix')
local json = require('dkjson')

local UEBERZUGPP_TMPDIR = os.getenv("HOME") .. "/.cache/ueberzugpp"
local FIFO_UEBERZUGPP

local function cleanup()
    if FIFO_UEBERZUGPP then
        os.execute("rm " .. FIFO_UEBERZUGPP)
    end
end

local function execute(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return result
end

local function image(path, width, height, x, y)
    if posix.access(path, "f") and os.getenv("DISPLAY") and not os.getenv("WAYLAND_DISPLAY") then
        local ueberzug_available = os.execute("command -v ueberzugpp >/dev/null 2>&1") == 0
        if ueberzug_available then
            local json_data = {
                action = "add",
                identifier = "PREVIEW",
                x = tostring(x),
                y = tostring(y),
                width = tostring(width - 1),
                height = tostring(height - 1),
                scaler = "contain",
                path = path
            }
            local json_string = json.encode(json_data)
            local fifo = assert(io.open(FIFO_UEBERZUGPP, "w"))
            fifo:write(json_string .. "\n")
            fifo:close()
        end
    end
end

local function preview(file, width, height, x, y)
    local mimetype = execute("file --dereference --brief --mime-type -- \"" .. file .. "\"")
    mimetype = mimetype:gsub("\n", "")

    if mimetype:match("image/.*") then
        image(file, width, height, x, y)
    elseif mimetype == "text/html" then
        os.execute("lynx -width=" .. width .. " -display_charset=utf-8 -dump \"" .. file .. "\"")
    elseif mimetype == "text/troff" then
        os.execute("man ./\"" .. file .. "\" | col -b")
    elseif mimetype:match("text/.*") or mimetype:match("application/json") then
        os.execute("bat -p --theme ansi --terminal-width " .. (width - 3) .. " -f \"" .. file .. "\"")
    elseif mimetype:match("video/.*") then
        local cache_path = UEBERZUGPP_TMPDIR .. "/thumb." .. execute("stat --printf '%n\\0%i\\0%F\\0%s\\0%W\\0%Y' -- \"" .. file .. "\" | sha256sum | cut -d' ' -f1"):gsub("\n", "")
        if not posix.access(cache_path, "f") then
            os.execute("ffmpegthumbnailer -i \"" .. file .. "\" -o \"" .. cache_path .. "\" -s 0")
        end
        image(cache_path, width, height, x, y)
    elseif mimetype:match("application/pgp-encrypted") then
        os.execute("gpg -d -- \"" .. file .. "\"")
    else
        print("Unsupported file type: " .. mimetype)
    end
end

local function main()
    FIFO_UEBERZUGPP = UEBERZUGPP_TMPDIR .. "/ueberzug-" .. posix.getpid()
    posix.mkdir(UEBERZUGPP_TMPDIR, "0700")
    if not posix.access(FIFO_UEBERZUGPP, "p") then
        os.execute("mkfifo " .. FIFO_UEBERZUGPP)
    end

    posix.signal(posix.SIGHUP, cleanup)
    posix.signal(posix.SIGINT, cleanup)
    posix.signal(posix.SIGQUIT, cleanup)
    posix.signal(posix.SIGTERM, cleanup)
    posix.signal(posix.SIGPWR, cleanup)
    posix.signal(posix.SIGEXIT, cleanup)

    local args = { ... }
    local file = args[1]
    local width = tonumber(args[2])
    local height = tonumber(args[3])
    local x = tonumber(args[4])
    local y = tonumber(args[5])

    preview(file, width, height, x, y)
end

main()

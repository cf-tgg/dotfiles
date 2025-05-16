-- ~& [ acompressor.lua ] [ Last Update: 2024-11-28 15:41 ]
-- filter including key bindings for adjusting parameters.
--
-- See https://ffmpeg.org/ffmpeg-filters.html#acompressor for explanation
-- of the parameters.

local mp = require("mp")
local options = require("mp.options")

local o = {
	default_enable = true,
	show_osd = true,
	osd_timeout = 4000,
	filter_label = mp.get_script_name(),

	key_toggle = "c",
	key_increase_threshold = "Ctrl+t",
	key_decrease_threshold = "Ctrl+Alt+t",
	key_increase_ratio = "Ctrl+o",
	key_decrease_ratio = "Ctrl+Alt+o",
	key_increase_knee = "Ctrl+y",
	key_decrease_knee = "Ctrl+Alt+y",
	key_increase_makeup = "Ctrl+m",
	key_decrease_makeup = "Ctrl+Alt+m",
	key_increase_attack = "Ctrl+a",
	key_decrease_attack = "Ctrl+Alt+a",
	key_increase_release = "Ctrl+r",
	key_decrease_release = "Ctrl+Alt+r",

	default_threshold = -12.5,
	default_ratio = 4.0,
	default_knee = 6.0,
	default_makeup = 8.0,
	default_attack = 40.0,
	default_release = 80.0,

	step_threshold = -2.5,
	step_ratio = 1.0,
	step_knee = 1.0,
	step_makeup = 1.0,
	step_attack = 10.0,
	step_release = 10.0,
}
options.read_options(o)

local params = {
	{ name = "attack", min = 40.0, max = 2000, hide_default = false, dB = "" },
	{ name = "release", min = 30.00, max = 9000, hide_default = false, dB = "" },
	{ name = "threshold", min = -30, max = 0, hide_default = false, dB = "dB" },
	{ name = "ratio", min = 1, max = 20, hide_default = false, dB = "" },
	{ name = "knee", min = 1, max = 10, hide_default = false, dB = "dB" },
	{ name = "makeup", min = 0, max = 24, hide_default = false, dB = "dB" },
}

local function parse_value(value)
	-- Using nil here because tonumber differs between lua 5.1 and 5.2 when parsing fractions in combination with explicit base argument set to 10.
	-- And we can't omit it because gsub returns 2 values which would get unpacked and cause more problems. Gotta love scripting languages.
	return tonumber(value:gsub("dB$", ""), nil)
end

local function format_value(value, dB)
	return string.format("%g%s", value, dB)
end

local function show_osd(filter)
	if not o.show_osd then
		return
	end

	if not filter.enabled then
		mp.commandv("show-text", "Dynamic range compressor: disabled", o.osd_timeout)
		return
	end

	local pretty = {}
	for _, param in ipairs(params) do
		local value = parse_value(filter.params[param.name])
		if not (param.hide_default and value == o["default_" .. param.name]) then
			pretty[#pretty + 1] = string.format("%s: %g%s", param.name:gsub("^%l", string.upper), value, param.dB)
		end
	end

	if #pretty == 0 then
		pretty = ""
	else
		pretty = "\n(" .. table.concat(pretty, ", ") .. ")"
	end

	mp.commandv("show-text", "Dynamic range compressor: enabled" .. pretty, o.osd_timeout)
end

local function get_filter()
	local af = mp.get_property_native("af", {})

	for i = 1, #af do
		if af[i].label == o.filter_label then
			return af, i
		end
	end

	af[#af + 1] = {
		name = "acompressor",
		label = o.filter_label,
		enabled = false,
		params = {},
	}

	for _, param in pairs(params) do
		af[#af].params[param.name] = format_value(o["default_" .. param.name], param.dB)
	end

	return af, #af
end

local function toggle_acompressor()
	local af, i = get_filter()
	af[i].enabled = not af[i].enabled
	mp.set_property_native("af", af)
	show_osd(af[i])
end

local function update_param(name, increment)
	for _, param in pairs(params) do
		if param.name == string.lower(name) then
			local af, i = get_filter()
			local value = parse_value(af[i].params[param.name])
			value = math.max(param.min, math.min(value + increment, param.max))
			af[i].params[param.name] = format_value(value, param.dB)
			af[i].enabled = true
			mp.set_property_native("af", af)
			show_osd(af[i])
			return
		end
	end

	mp.msg.error('Unknown parameter "' .. name .. '"')
end

mp.add_key_binding(o.key_toggle, "toggle-acompressor", toggle_acompressor)
mp.register_script_message("update-param", update_param)

for _, param in pairs(params) do
	for direction, step in pairs({ increase = 1, decrease = -1 }) do
		mp.add_key_binding(
			o["key_" .. direction .. "_" .. param.name],
			"acompressor-" .. direction .. "-" .. param.name,
			function()
				update_param(param.name, step * o["step_" .. param.name])
			end,
			{ repeatable = true }
		)
	end
end

if o.default_enable then
	local af, i = get_filter()
	af[i].enabled = true
	mp.set_property_native("af", af)
end

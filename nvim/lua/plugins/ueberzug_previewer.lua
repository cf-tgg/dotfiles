-- ~& [ ueberzug_previewer.lua ] [ Last Update: 2024-10-25 03:42 ]

local M = {}

local function start_preview(filepath, bufnr)
  local term = vim.api.nvim_open_term(bufnr, {})

  local function send_output(_, data, _)
    for _, d in ipairs(data) do
      vim.api.nvim_chan_send(term, d..'\r\n')
    end
  end

  -- Start the preview job
  local preview_job_id = vim.fn.jobstart({
    'bash',
    vim.fn.expand('~/.local/bin/lfub'),
    filepath
  }, {
    on_stdout = send_output,
    stdout_buffered = true,
    pty = true,
    on_exit = function(job_id, exit_code)
      vim.fn.jobstart({
        'bash',
        vim.fn.expand('~/.local/bin/cleaner')
      })
    end
  })

  return preview_job_id
end

require("telescope").setup {
  defaults = {
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = {'png', 'jpg', 'jpeg', 'gif', 'bmp'}
          local extension = vim.fn.fnamemodify(filepath, ':e')
          return vim.tbl_contains(image_extensions, extension)
        end

        if is_image(filepath) then
          -- Clean up before starting a new preview
          vim.fn.jobstart({
            'bash',
            vim.fn.expand('~/.local/bin/cleaner')
          })

          -- Start the new preview job
          start_preview(filepath, bufnr)

        else
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
        end
      end
    },
  }
}

return M

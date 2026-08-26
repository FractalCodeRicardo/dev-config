local ns = vim.api.nvim_create_namespace('my.dir.classify')

vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, _, buf)
    return vim.bo[buf].filetype == 'directory'
  end,
  on_range = function(_, _, buf, row)
    local name = vim.api.nvim_buf_get_lines(buf, row, row + 1, true)[1]
    vim.api.nvim_buf_set_extmark(buf, ns, row, #name, {
      virt_text = { { ' 󰄛  ', 'Dimmed' } },
      virt_text_pos = 'overlay',
      ephemeral = true,
    })
    return row + 1
  end,
})

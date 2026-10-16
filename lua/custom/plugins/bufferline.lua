-- Bufferline buffer bar.
-- https://github.com/akinsho/bufferline.nvim
--
-- Bufferline v4 renders its buffer list in the **tabline** (top row), which
-- coexists with the mini.statusline bar at the bottom — so the two don't
-- conflict.
---@module 'lazy'
---@type LazySpec
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Always show the tabline so the buffer row is visible even when there is
    -- only one tab page (Neovim hides the tabline otherwise).
    vim.o.showtabline = 2

    require('bufferline').setup {
      options = {
        mode = 'buffers',
        -- Show LSP diagnostic indicators (errors/warnings) on each buffer.
        diagnostics = 'nvim_lsp',
      },
    }

    -- Tab / Shift-Tab cycle to the next / previous buffer in the bufferline
    -- (bufferline registers these commands during the setup above).
    vim.keymap.set({ 'n', 'v' }, '<Tab>',   ':BufferLineCycleNext<CR>', { desc = 'Next buffer' })
    vim.keymap.set({ 'n', 'v' }, '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })

    -- <leader>x closes the current buffer. Uses native :bd (bdelete) rather
    -- than a bufferline command, since v4 has no "close current buffer"
    -- command. Guarded so the last remaining *listed* buffer is never
    -- deleted (closing a non-listed window such as a terminal or quickfix is
    -- always safe), and non-force so unsaved changes are not silently
    -- discarded.
    vim.keymap.set('n', '<leader>x', function()
      local current = vim.api.nvim_get_current_buf()
      local listed = vim.fn.getbufinfo({ buflisted = 1 })
      local current_listed = false
      for _, b in ipairs(listed) do
        if b.bufnr == current then
          current_listed = true
          break
        end
      end
      if current_listed and #listed < 2 then
        print('Not closing the only open buffer')
        return
      end
      vim.cmd('bd')
    end, { desc = 'Close current buffer' })
  end,
}

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

    -- <leader>x closes the current buffer with native :bd (bdelete) rather
    -- than a bufferline command (v4 has no "close current buffer" command).
    -- Deliberately unconditional: closing the last buffer is safe — Neovim
    -- just drops you into a fresh empty buffer rather than quitting or
    -- crashing — and a non-force :bd still refuses to discard unsaved
    -- changes (E37).
    vim.keymap.set('n', '<leader>x', function()
      vim.cmd('bd')
    end, { desc = 'Close current buffer' })
  end,
}

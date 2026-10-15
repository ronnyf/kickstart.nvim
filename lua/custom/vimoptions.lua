-- User-specific Neovim options and settings.
--
-- Home for your own customizations (options, keymaps, autocommands, etc.) that
-- you want to keep out of the upstream `init.lua` so you avoid merge conflicts
-- when you sync kickstart.nvim. `lua/custom/` is the designated no-conflict
-- zone (see `lua/custom/plugins/init.lua`).
--
-- It is required from `init.lua` (see the `-- [[ Setting options ]]` section),
-- which runs *before* `require('lazy').setup(...)`. That ordering matters:
-- anything set here takes effect before plugins load, so e.g. `termguicolors`
-- is in place before the tokyonight colorscheme is applied.
--
-- NOTE: This file runs for its side effects and returns nothing. That's
-- different from the files in `lua/custom/plugins/`, which each return a
-- plugin spec (LazySpec) for lazy.nvim to install.

-- Enable 24-bit ("true color") rendering in the UI.
vim.o.termguicolors = true

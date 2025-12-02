--[[
================================================================================
  Diagnostics Configuration
================================================================================
  Configure the appearance and behavior of LSP diagnostics.
================================================================================
--]]

-- Prevent LSP from overwriting treesitter color settings
vim.hl.priorities.semantic_tokens = 95

-- Diagnostic signs
local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = '󰌵 ',
}

-- Set diagnostic signs in the sign column
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnostic configuration
vim.diagnostic.config {
  -- Virtual text configuration
  virtual_text = {
    prefix = '●',
    spacing = 4,
    source = 'if_many',
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },

  -- Floating window configuration
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },

  -- General settings
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.INFO] = signs.Info,
      [vim.diagnostic.severity.HINT] = signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- vim: ts=2 sts=2 sw=2 et


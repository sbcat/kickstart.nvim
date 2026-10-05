 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#16130d',
    base01 = '#221f19',
    base02 = '#2d2a23',
    base03 = '#98907e',
    base04 = '#cfc6b2',
    base05 = '#e9e2d7',
    base06 = '#e9e2d7',
    base07 = '#e9e2d7',
    base08 = '#ffb4ab',
    base09 = '#d9f5a0',
    base0A = '#d7c599',
    base0B = '#ffe8ac',
    base0C = '#b6d07f',
    base0D = '#e3c466',
    base0E = '#d7c599',
    base0F = '#f4e1b3',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e9e2d7',          bg = '#16130d' })
  hi('TelescopeBorder',         { fg = '#98907e',             bg = '#16130d' })
  hi('TelescopePromptNormal',   { fg = '#e9e2d7',          bg = '#16130d' })
  hi('TelescopePromptBorder',   { fg = '#98907e',             bg = '#16130d' })
  hi('TelescopePromptPrefix',   { fg = '#ffe8ac',             bg = '#16130d' })
  hi('TelescopePromptCounter',  { fg = '#cfc6b2',  bg = '#16130d' })
  hi('TelescopePromptTitle',    { fg = '#16130d',             bg = '#ffe8ac' })
  hi('TelescopePreviewTitle',   { fg = '#16130d',             bg = '#d7c599' })
  hi('TelescopeResultsTitle',   { fg = '#16130d',             bg = '#d9f5a0' })
  hi('TelescopeSelection',      { fg = '#e9e2d7',          bg = '#2d2a23' })
  hi('TelescopeSelectionCaret', { fg = '#ffe8ac',             bg = '#2d2a23' })
  hi('TelescopeMatching',       { fg = '#ffe8ac',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e9e2d7',          bg = '#16130d' })
  hi('MiniPickBorder',         { fg = '#98907e',             bg = '#16130d' })
  hi('MiniPickPrompt',   { fg = '#e9e2d7',          bg = '#16130d' })
  hi('MiniPickPromptPrefix',   { fg = '#ffe8ac',             bg = '#16130d' })
  hi('MiniPickBorderText',    { fg = '#16130d',             bg = '#ffe8ac' })
  hi('MiniPickMatchCurrent',      { fg = '#e9e2d7',          bg = '#2d2a23' })
  hi('MiniPickPromptCaret', { fg = '#ffe8ac',             bg = '#2d2a23' })
  hi('MiniPickMatchRanges',       { fg = '#ffe8ac',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M

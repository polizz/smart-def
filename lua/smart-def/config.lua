local M = {}

M.default_config = {
  prefix = "gd",
  -- Default key mappings
  mappings = {
    up = "k",        -- Open definition in a horizontal split above
    right = "l",     -- Open definition in a vertical split to the right
    down = "j",      -- Open definition in a horizontal split below
    left = "h",      -- Open definition in a vertical split to the left
    use_right = '>', -- Open def in exissting right window
    use_left = '<',  -- Open def in exissting left window
  },
  -- Delay before navigating to the definition (in milliseconds)
  delay = 75,
}

M.split_commands = {
  up = "split | wincmd k",    -- Horizontal split (below) and move up
  right = "vsplit",           -- Vertical split (left)
  down = "split",             -- Horizontal split (below)
  left = "vsplit | wincmd h", -- Vertical split (right) and move left
  use_right = "wincmd l",     -- Move focus to the RIGHT window
  use_left = "wincmd h"       -- Move focus to the LEFT window
}

M.descriptions = {
  up = "Show definition in a split above",
  right = "Show definition in a split right",
  down = "Show definition in a split below",
  left = "Show definition in a split left",
  use_right = "Show definition in a split right window",
  use_left = "Show definition in existing left window",
}

return M

Minimum configuration:

```lua
return {
  "polizz/smart-def.nvim",
  config = function()
    local opts
    -- local opts = {
    --   mappings = {
    --     prefix = "gd",         -- master key prefix
    --     mappings = {
    --       up = "k",            -- Open definition in a horizontal split above
    --       right = "l",         -- Open definition in a vertical split to the right
    --       down = "j",          -- Open definition in a horizontal split below
    --       left = "h",          -- Open definition in a vertical split to the left
    --       use_right = '>',     -- Open def in existing right window
    --       use_left = '<',      -- Open def in existing left window
    --     },
    --     -- Delay before navigating to the definition (in milliseconds) for split defs
    --     delay = 75,
    --   }
    -- }
    require("smart-def").setup(opts)
  end
}
```

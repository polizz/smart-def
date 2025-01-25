local config = require("smart-def.config")

local M = {}

-- Function to handle definition navigation
local function goto_definition_in_direction(map_dir, user_config)
  local cmd = config.split_commands[map_dir]
  if not cmd then
    print("Invalid direction. Use h, j, k, l, > or <.")
    return
  end

  -- Handle existing window navigation differently
  if map_dir == "use_right" or map_dir == "use_left" then
    -- Step 1: Store current buffer
    local buffer_a = vim.api.nvim_get_current_buf()
    -- Step 2: Jump to the LSP definition (opens buffer "B" in the current pane)
    vim.lsp.buf.definition()
    -- Step 3: Record the new buffer (buffer "B")
    local buffer_b = vim.api.nvim_get_current_buf()
    -- Step 4: Move back to buffer "A" in the current pane
    vim.api.nvim_set_current_buf(buffer_a)
    -- Step 5: Move to the target pane
    vim.cmd(cmd)
    -- Step 6: Show buffer "B" in the target pane
    vim.api.nvim_set_current_buf(buffer_b)
  else
    -- Handle new split creation
    vim.cmd(cmd)
    vim.defer_fn(vim.lsp.buf.definition, user_config.delay)
  end
end

function M.setup(user_opts)
  -- Merge user configuration with defaults
  local cfg = vim.tbl_deep_extend("force", config.default_config, user_opts or {})

  -- Set up key mappings
  for map_dir, key_dir in pairs(cfg.mappings) do
    vim.keymap.set("n", cfg.prefix .. key_dir, function()
      goto_definition_in_direction(map_dir, cfg)
    end, {
      desc = config.descriptions[map_dir],
      noremap = true,
      silent = true,
    })
  end
end

return M

local config = require("smart-def.config")

local M = {}
local function goto_definition_in_direction(map_dir)
  local cmd = config.split_commands[map_dir]
  if not cmd then
    print("Invalid direction.")
    return
  end

  -- 1. Get the definition location WITHOUT jumping immediately
  -- We use vim.lsp.buf_request to get the raw data from the server
  local params = vim.lsp.util.make_position_params(0, "utf-8")
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      print("Definition not found")
      return
    end

    -- The LSP returns a list of locations; we take the first one
    local location = result[1]
    if type(location) == "table" then
      -- Handle case where result is a list of locations { uri, range }
      location = location[1] or location
    end

    vim.cmd(cmd)

    -- Step B: Open the specific buffer and position from the LSP result
    -- vim.lsp.util.jump_to_location(location)
    vim.lsp.util.show_document(location, "utf-8")
    vim.cmd("norm! zz")
  end)
end
function M.setup(user_opts)
  -- Merge user configuration with defaults
  local cfg = vim.tbl_deep_extend("force", config.default_config, user_opts or {})

  -- Set up key mappings
  for map_dir, key_dir in pairs(cfg.mappings) do
    vim.keymap.set("n", cfg.prefix .. key_dir, function()
      goto_definition_in_direction(map_dir)
    end, {
      desc = config.descriptions[map_dir],
      noremap = true,
      silent = true,
    })
  end
end

return M

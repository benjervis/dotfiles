return {}
-- return {
--   {
--     "microsoft/vscode-js-debug",
--     build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
--   },
--   {
--     "mxsdev/nvim-dap-vscode-js",
--     init = function()
--       vim.fn.stdpath("data")
--       require("dap-vscode-js").setup({
--         debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
--         adapters = { "pwa-node" },
--       })
--
--       for _, language in ipairs({ "typescript", "javascript" }) do
--         require("dap").configurations[language] = {
--           {
--             type = "pwa-node",
--             request = "launch",
--             name = "Run Mocha tests",
--             runtimeExecutable = "yarn",
--             runtimeArgs = {
--               "just-mocha",
--             },
--             cwd = "${workspaceFolder}",
--           },
--           {
--             type = "pwa-node",
--             request = "launch",
--             name = "Yarn start",
--             runtimeExecutable = "yarn",
--             runtimeArgs = { "start" },
--             cwd = "${workspaceFolder}",
--           },
--           {
--             type = "pwa-node",
--             request = "attach",
--             name = "Attach",
--             processId = require("dap.utils").pick_process,
--             cwd = "${workspaceFolder}",
--           },
--         }
--       end
--     end,
--   },
-- }

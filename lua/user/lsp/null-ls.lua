local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

-- Custom autopep8 builtin
local autopep8 = helpers.make_builtin({
  name = "autopep8",
  meta = {
    url = "https://github.com/hhatto/autopep8",
    description = "Format Python code to conform to (most of) PEP 8 / flake8.",
  },
  method = methods.internal.FORMATTING,
  filetypes = { "python" },
  generator_opts = {
    command = "autopep8",
    args = {
      "--aggressive",
      "--aggressive",
      -- example options for flake8-ish style:
      -- "--max-line-length", "88",
      -- "--ignore", "E203,W503",
      "-" ,
    },
    to_stdin = true,
  },
  factory = helpers.formatter_factory,
})

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = true,
  sources = {
    autopep8,
  },
})

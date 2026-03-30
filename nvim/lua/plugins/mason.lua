return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- FORMATTERS
      "stylua", -- Lua
      "shfmt", -- Shell
      "black", -- Python
      "isort", -- Python import sorter
      "markdownlint-cli2", -- Markdown linter
      "tflint", -- Terraform
    },
  },
}

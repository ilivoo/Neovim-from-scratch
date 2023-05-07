local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
local actions = null_ls.builtins.code_actions

local completions = null_ls.builtins.completion

local hovers = null_ls.builtins.hover

null_ls.setup({
	debug = false,
	sources = {
    -- all
    -- actions.cspell,
    -- git
    actions.gitrebase,
    actions.gitsigns,
    -- markdown
    actions.proselint,
    -- go python lua
    actions.refactoring,
    -- shell
    actions.shellcheck,

    -- all
    completions.spell,
    completions.tags,

    -- all
    -- diagnostics.misspell,
    diagnostics.codespell,
    -- diagnostics.cspell,
    --markdown
    diagnostics.markdownlint,
    -- diagnostics.proselint,
    diagnostics.mdl,
    -- python
    diagnostics.flake8,
    diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    -- ansible
    diagnostics.ansiblelint,
    -- clang
    diagnostics.cpplint,
    diagnostics.checkmake,
    -- diagnostics.clang_check,
    diagnostics.cmake_lint,
    -- java
    -- diagnostics.checkstyle.with({
    --    extra_args = { "-c", "/sun_checks.xml" }, -- or "/google_checks.xml" or path to self written rules
    -- }),
    -- git
    diagnostics.gitlint,
    -- go
    -- diagnostics.golangci_lint,
    diagnostics.staticcheck,
    -- json yaml
    diagnostics.jsonlint,
    diagnostics.yamllint,
    -- docker
    diagnostics.hadolint,
    --sql
    -- diagnostics.sqlfluff.with({ extra_args = { "--dialect", "mysql" } }),

    -- all
    formatting.prettierd,
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    -- formatting.codespell,
    -- formatting.trim_newlines,
    -- formatting.trim_whitespace,
    -- go
    -- formatting.gofmt,
    -- formatting.gofumpt,
    -- formatting.goimports,
    -- formatting.golines,
    -- formatting.goimports_reviser,
    -- lua
    formatting.stylua,
    -- bash
    formatting.shfmt,
    -- markdown
    formatting.markdownlint,
    formatting.mdformat,
    -- java
    formatting.google_java_format,
    formatting.scalafmt,
    formatting.npm_groovy_lint,
    -- json
    -- formatting.fixjson,
    formatting.jq,
    -- formatting.json_tool,
    -- xml
    formatting.xmllint,
    formatting.yamlfmt,
    formatting.latexindent,
    -- clang
    formatting.clang_format,
    formatting.cmake_format,
    -- python
    formatting.autopep8,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.blue,
    formatting.isort,
    formatting.usort,
    formatting.reorder_python_imports,
    formatting.yapf,
    -- sql
    -- formatting.sqlformat,
    -- formatting.sql_formatter,
    -- formatting.sqlfluff.with({ extra_args = { "--dialect", "mysql" }}),

    hovers.dictionary,
    hovers.printenv,
	},
})

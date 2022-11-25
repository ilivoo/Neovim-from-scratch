local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Buffers" },
  ["B"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" }, -- g? 帮助
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  -- ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["p"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["f"] = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Find files" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["m"] = { "<cmd>Telescope marks<cr>", "Marks" }, -- g`a 跳转到 mark a 的光标位置，g'a 跳转到 mark a 的还首

  g = {
    name = "Git",
    -- g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame Line" }, -- lua require"gitsigns".blame_line{full=true}
    L = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Blame Line" }, -- lua require"gitsigns".blame_line{full=true}
    t = { "<cmd>lua require 'gitsigns'.select_hunk()<cr>", "Next Hunk" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    S = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    r = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    d = { "<cmd>Gitsigns diffthis<cr>", "Diff Stage" },
    D = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff Head" }, -- lua require"gitsigns".diffthis("~")
    n = { "<cmd>Gitsigns toggle_deleted<cr>", "Show deleted" },
    f = { "<cmd>Telescope git_files<cr>", "Files" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Branch" },
    c = { "<cmd>Telescope git_bcommits<cr>", "File commit" },
    C = { "<cmd>Telescope git_commits<cr>", "All commit" },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    c = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest" },
    f = { "<cmd>lua vim.lsp.buf.formatting{async=true}<cr>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover(k)" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" }, -- D = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Document Diagnostics" },
    D = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope treesitter<cr>", "Document Treesitter" },
    w = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Current Document Symbols" },
    W = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "All Workspace Symbols" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    -- Telescope tags
    -- Telescope current_buffer_tags
  },

  j = {
    name = "Jump",
    j = { "<cmd>Telescope jumplist<cr>", "Jump List" }, -- ctrl-i/o 光标前后跳转
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Declaration(gr)" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration(gD)" },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definitions(gd)" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definitions(gt)" },
    h = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementations(gh)" },
    i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "Incoming Call(gi)" },
    o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", "Outgoing Call(go)" },
  },

  s = {
    name = "Search",
    h = { "<cmd>Telescope oldfiles<cr>", "History File" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope registers<cr>", "Registers" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Buffer" },
    B = { "<cmd>Telescope buffers<cr>", "Buffers File" },
    s = { "<cmd>Telescope grep_string<cr>", "Search Cursor Word" },
    H = { "<cmd>Telescope search_history<cr>", "Search History" },
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

  h = {
    name = "Help",
    c = { "<cmd>Telescope commands<cr>", "Command" },
    C = { "<cmd>Telescope command_history<cr>", "Command History" },
    m = { "<cmd>Telescope man_pages<cr>", "Man"},
    o = { "<cmd>Telescope vim_options<cr>", "Vim Options"},
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags"},
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps"},
    r = { "<cmd>Telescope resume<cr>", "Resume Command"},
    t = { "<cmd>Telescope colorscheme<cr>", "Theme"},
    w = { "<cmd>WhichKey<cr>", "WhichKey"}, -- show all mappings
    -- c = { "<cmd>PackerCompile<cr>", "Packer Compile" },
    i = { "<cmd>PackerInstall<cr>", "Packer Install" },
    s = { "<cmd>PackerSync<cr>", "Packer Sync" },
    S = { "<cmd>PackerStatus<cr>", "Packer Status" },
    u = { "<cmd>PackerUpdate<cr>", "Packer Update" },
    -- :WhichKey '' v " show ALL mappings for VISUAL mode
    -- :WhichKey <leader> " show all <leader> mappings
    -- :WhichKey <leader> v " show all <leader> mappings for VISUAL mode
    -- g z gc_ gb_
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)

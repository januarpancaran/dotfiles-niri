if vim.g.vscode then
    require("plugins.comment-nvim")
    require("plugins.indent-blankline-nvim")
    require("plugins.markdown-preview-nvim")
    require("plugins.nvim-treesitter-context")
    require("plugins.rainbow-delimiters-nvim")

else
    require("config.lazy")
end

require("config.options")
require("config.mappings")

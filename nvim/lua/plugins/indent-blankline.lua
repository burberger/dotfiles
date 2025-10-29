return {
    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
        version = "*",
        opts = {
            indent = {
                char = "▏",
            },
        },
        config = function(_, opts)
            require("ibl").setup(opts)
        end,
    }
}

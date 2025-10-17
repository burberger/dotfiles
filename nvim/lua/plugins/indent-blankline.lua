return {
    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
        version = "*",
        config = function(_, _)
            require("ibl").setup()
        end,
    }
}

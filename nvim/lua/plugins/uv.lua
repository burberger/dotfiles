-- Python package management integration
return {
    "benomahony/uv.nvim",
    ft = { "python" },
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        picker_integration = true,
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = { 'c', 'cpp', 'css', 'typescript', 'html', 'lua', 'rust', 'tsx',
                'vhdl', 'yaml', 'python', 'bash', 'c_sharp', 'fsharp', 'go',
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 1000 * 1024 -- 1MiB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                    return false
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}

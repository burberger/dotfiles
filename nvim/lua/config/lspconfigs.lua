-- Diagnostics
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
})

-- Lua
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
        telemetry = {
            enable = false,
        },
        workspace = {
            checkThirdParty = false,
            library = {
                vim.env.VIMRUNTIME,
            },
        },
    },
})

-- Autocomplete
vim.opt.completeopt = {'menuone', 'noselect', 'popup'}
vim.opt.shortmess:append('c')
vim.opt.pumheight = 10

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})


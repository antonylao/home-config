return {
  "neoclide/coc.nvim",
  branch = "release",
  config = function()
    local keyset = vim.keymap.set

    keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
    keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
    keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

    keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    keyset("i", "<C-n>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
      opts)
    keyset("i", "<C-p>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

    -- <C-g>u breaks current undo, please make your own choice
    keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

    -- doesnt seem to work
    -- Use <c-j> to trigger snippets
    -- needs an extension?
    -- keyset("i", "<c-k>", "<Plug>(coc-snippets-expand-jump)")

    -- Use <c-space> to trigger completion
    keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

    -- Use K to show documentation in preview window
    function _G.show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end

    keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

    local opts = { silent = true, nowait = true }
    keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)

    keyset("n", "<leader>k", "<Plug>(coc-diagnostic-prev)", { silent = true })
    keyset("n", "<leader>j", "<Plug>(coc-diagnostic-next)", { silent = true })

    -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
    vim.api.nvim_create_augroup("CocGroup", {})
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "CocGroup",
      command = "silent call CocActionAsync('highlight')",
      desc = "Highlight symbol under cursor on CursorHold"
    })
  end
}

-- use :help lspconfig-all ..??
-- install with :LspInstall or :Mason, then i on the lsp
-- check install with :echo executable('name_of_lsp'): 1 means yes
-- insert lsp inside lspconfig config =
return {
	-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
	{ "williamboman/mason.nvim", opts = {} },
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- status updates for LSP. Distracting
	{ "j-hui/fidget.nvim", opts = {} },

	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			--{ 'williamboman/mason.nvim', opts = {} },
			--'williamboman/mason-lspconfig.nvim',
			--'WhoIsSethDaniel/mason-tool-installer.nvim',
			-- status updates for LSP. Distracting
			--{ 'j-hui/fidget.nvim', opts = {} },
			-- Allows extra capabilities provided by blink.cmp: completion plugin
			"saghen/blink.cmp",
			{
				-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},

		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }

					-- get infos from code
					-- NB: also, <leader>th to toggle inlay hints (defined after)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("i", "<C-k>", function()
						vim.lsp.buf.signature_help()
					end, opts)
					-- vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
					vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

					-- jumping in the code
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts) --<C-t> to go back
					vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, opts)
					vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
					-- NB : jumps to the definition of its *type*, not where it was *defined*.
					vim.keymap.set("n", "<leader>grt", require("telescope.builtin").lsp_type_definitions, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>gs", require("telescope.builtin").lsp_document_symbols, opts)
					vim.keymap.set("n", "<leader>gS", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
					vim.keymap.set("n", "<leader>ge", function()
						require("telescope.builtin").diagnostics({ bufnr = 0 })
					end, opts)
					vim.keymap.set("n", "<leader>gE", require("telescope.builtin").diagnostics, opts)

					-- antony ~ 2025-05-05: below not really used
					-- go to list of references
					vim.keymap.set("n", "<leader>glr", vim.lsp.buf.references, opts)
					-- Jump to the implementation
					--  Useful when your language has ways of declaring types without an actual implementation.
					vim.keymap.set("n", "<leader>gti", require("telescope.builtin").lsp_implementations, opts)
					-- Jump to the definition
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					vim.keymap.set("n", "<leader>gtd", require("telescope.builtin").lsp_definitions, opts)
					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					vim.keymap.set("n", "<leader>grD", vim.lsp.buf.declaration, opts)

					-- below are autocommands to highlight references of the word under cursor
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					--          local function client_supports_method(client, method, bufnr)
					--            if vim.fn.has 'nvim-0.11' == 1 then
					--              return client:supports_method(method, bufnr)
					--            else
					--              return client.supports_method(method, { bufnr = bufnr })
					--            end
					--          end
					if
						client
						and client:supports_method(
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup = vim.api.nvim_create_augroup("multiple-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(detach_event)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "multiple-highlight", buffer = detach_event.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if
						client
						and client:supports_method(
							vim.lsp.protocol.Methods.textDocument_inlayHint,
							 event.buf
						)
					then
						vim.keymap.set("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, opts)
					end
				end,
			})

			-- Diagnostic Config: disable float and underline because handled by lua_lines
			-- See :help vim.diagnostic.Opts
			--local isLspDiagnosticsVisible = true
			--vim.keymap.set("n", "<leader>tx", function()
			--  isLspDiagnosticsVisible = not isLspDiagnosticsVisible
			--  vim.diagnostic.config({
			--    virtual_text = isLspDiagnosticsVisible,
			--    underline = isLspDiagnosticsVisible
			--  })
			--end)
			--//TODO

			--require("lsp_lines").setup()
			vim.keymap.set("n", "<Leader>tx", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				--underline = { severity = vim.diagnostic.severity.ERROR },
				underline = false,

				--vim.g.have_nerd_font and {
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = false,
				--virtual_text = {
				--  source = 'if_many',
				--  spacing = 2,
				--  format = function(diagnostic)
				--    local diagnostic_message = {
				--      [vim.diagnostic.severity.ERROR] = diagnostic.message,
				--      [vim.diagnostic.severity.WARN] = diagnostic.message,
				--      [vim.diagnostic.severity.INFO] = diagnostic.message,
				--      [vim.diagnostic.severity.HINT] = diagnostic.message,
				--    }
				--    return diagnostic_message[diagnostic.severity]
				--  end,
				--},
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
				-- ts_ls = {},

				lua_ls = {

					-- cmd = { ... },
					-- filetypes = { ... },
					-- capabilities = {},
					settings = {
						Lua = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							completion = {
								--callSnippet = 'Replace',
								--when autocompleting snippets, replace the name
								--with a snippet with placehoder arguments
								-- other value: 'Disable',
								callSnippet = "Replace",
							},
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = {
							disable = { "missing-fields" },
							globals = { "vim", "require" },
						},
					},
				},
			}
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (we populate installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				-- local disable_filetypes = { c = true, cpp = true }
				local disable_filetypes = {}
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
			formatters = {
				--shfmt = { options = { switch_case_indent = true } },
				shfmt = { prepend_args = { "-ci" } },
			},
		},
	},

	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			-- Snippet Engine
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				-- 'default' (recommended) for mappings similar to built-in completions
				--   <c-y> to accept ([y]es) the completion.
				--    This will auto-import if your LSP supports it.
				--    This will expand snippets if the LSP sent a snippet.
				-- 'super-tab' for tab to accept
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				preset = "default",

				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				-- By default, you may press `K` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				--documentation = { auto_show = false, auto_show_delay_ms = 500 },
				documentation = { auto_show = false },
			},

			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See :h blink-cmp-config-fuzzy for more information
			fuzzy = { implementation = "lua" },

			-- Shows a signature help window while you type arguments for a function
			signature = { enabled = false },
		},
	},
}

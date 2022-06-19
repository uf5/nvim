(import-macros {: let!} :macros.variable-macros)

(local which-key (require :which-key))
(λ key [tbl prop] [(. tbl prop) prop])

;; set leader key
(let! mapleader " ")
(let! maplocalleader " m")

;; easier command line mode
(which-key.register {";" [":" "vim-ex"]})

(which-key.register {"f" ["<CMD>HopWord<CR>" "Hop"]})

;; Visuals
(which-key.register {"<leader>t" {:name "Visuals"
                                  "h" ["<cmd>TSHighlightCapturesUnderCursor<cr>" "Capture Highlight"]
                                  "p" ["<cmd>TSPlayground<cr>" "Playground"]
                                  "w" ["<cmd>set wrap!<cr>" "linewrap"]
                                  "z" ["<cmd>TZAtaraxis<cr>" "truezen"]}})

;; Conjure
(which-key.register {"<localleader>E" "eval motion"
                     "<localleader>e" "execute"
                     "<localleader>l" "log"
                     "<localleader>r" "reset"
                     "<localleader>t" "test"})

;; Lsp
(λ set-lsp-keys! [bufnr]
  (which-key.register {"<leader>d" {:name "lsp"
                                    ; inspect
                                    "d" (key vim.lsp.buf :definition)
                                    "D" (key vim.lsp.buf :declaration)
                                    "i" (key vim.lsp.buf :implementation)
                                    "t" (key vim.lsp.buf :type_definition)
                                    "s" (key vim.lsp.buf :signature_help)
                                    "h" (key vim.lsp.buf :hover)
                                    "R" (key vim.lsp.buf :references)
                                    ; diagnstic
                                    "k" (key vim.diagnostic :goto_prev)
                                    "j" (key vim.diagnostic :goto_next)
                                    "w" (key vim.diagnostic :open_float)
                                    "q" (key vim.diagnostic :setloclist)
                                    ; code
                                    "r" (key vim.lsp.buf :rename)
                                    "a" (key vim.lsp.buf :code_action)
                                    "f" (key vim.lsp.buf :formatting)}
                       "<leader>W" {:name "lsp workspace"
                                    "a" (key vim.lsp.buf :add_workspace_folder)
                                    "r" (key vim.lsp.buf :remove_workspace_folder)
                                    "l" [(fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                                         "list_workspace_folders"]}
                       ; reassgn some builtin mappings
                       "gd" (key vim.lsp.buf :definition)
                       "gD" (key vim.lsp.buf :declaration)
                       "<leader>E" (key vim.lsp.buf :hover)
                       "<leader>e" (key vim.diagnostic :open_float)}
               {:buffer bufnr}))

(which-key.register {"<leader>g" ["<cmd>Neogit<CR>" "Neogit"]})

;; Telescope
(which-key.register {"<leader>b" ["<cmd>Telescope buffers<CR>" "Buffers"]})
(which-key.register {"<leader>p" ["<cmd>lua require('telescope').extensions.project.project({ display_type = 'full' })<CR>" "Projects"]})
(which-key.register {"<leader>:" ["<cmd>Telescope commands<CR>" "M-x"]})
(which-key.register {"<leader>f" ["<cmd>Telescope find_files<cr>" "Find files"]})
(which-key.register {"<leader>F" ["<cmd>Telescope live_grep<cr>" "Greep"]})

{: set-lsp-keys!}

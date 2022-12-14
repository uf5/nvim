(require-macros :macros.package-macros)

;; Setup packer
(local {: init} (require :packer))
(init {:autoremove true
       :git {:clone_timeout 300}
       :profile {:enable true}
       :compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)})

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

;; Packer can manage itself
(use-package! :wbthomason/packer.nvim)

;; Mapping and Documentation
(use-package! :folke/which-key.nvim {:config (call-setup :which-key)})

;; lispy configs
(use-package! :Olical/conjure
              {:branch :develop
               :ft lisp-ft
               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)
               :requires [(match fennel_compiler
                            :hotpot (pack :rktjmp/hotpot.nvim {:branch :master})
                            :aniseed (pack :Olica/aniseed
                                           {:branch :develop
                                            :requires [(pack :lewis6991/impatient.nvim)]})
                            :tangerine (pack :udayvir-singh/tangerine.nvim
                                             {:requires [(pack :lewis6991/impatient.nvim)]}))]})

(use-package! :windwp/nvim-autopairs {:config (call-setup :nvim-autopairs)})

(use-package! :eraserhd/parinfer-rust
              {:ft lisp-ft :cmd :ParinferOn :run "cargo build --release"})

(use-package! :nvim-lua/telescope.nvim
              {:config (load-file :telescope)
               :cmd :Telescope
               :requires [(pack :nvim-lua/plenary.nvim {:module :plenary})
                          (pack :nvim-telescope/telescope-project.nvim
                                {:module :telescope._extensions.project})
                          (pack :nvim-telescope/telescope-fzf-native.nvim
                                {:module :telescope._extensions.fzf :run :make})]})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :event [:BufRead :BufNewFile]
               :config (load-file :treesitter)
               :requires [(pack :nvim-treesitter/playground
                                {:cmd :TSPlayground})
                          (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects
                                {:after :nvim-treesitter})]})

;; lsp
(use-package! :williamboman/nvim-lsp-installer
              {:opt true :setup (defer! :nvim-lsp-installer 0)})

(use-package! :neovim/nvim-lspconfig
              {:after :nvim-lsp-installer
               :module :lspconfig
               :config (fn []
                         (require :pack.lspinstall)
                         (require :pack.lsp))})

(use-package! :ray-x/lsp_signature.nvim {:module :lsp_signature})
(use-package! :j-hui/fidget.nvim
              {:after :nvim-lspconfig :config (call-setup :fidget)})

;; git
(use-package! :TimUntersberger/neogit
              {:config (call-setup :neogit) :cmd :Neogit})
(use-package! :lewis6991/gitsigns.nvim
              {:opt true
               :setup (defer! :gitsigns.nvim 0)
               :config (call-setup :gitsigns)})

(use-package! :hrsh7th/nvim-cmp
              {:config (load-file :cmp)
               :wants [:LuaSnip]
               :event [:InsertEnter :CmdlineEnter]
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-cmdline {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                          (pack :lukas-reineke/cmp-under-comparator
                                {:module :cmp-under-comparator})
                          (pack :L3MON4D3/LuaSnip
                                {:event :InsertEnter
                                 :wants :friendly-snippets
                                 :config (load-file :luasnip)
                                 :requires [(pack :rafamadriz/friendly-snippets)]})]})

;; aesthetics
(use-package! :nvim-lualine/lualine.nvim {:config (load-file :lualine)})
(use-package! :monkoose/matchparen.nvim {:config (load-file :matchparen)})
(use-package! :Pocco81/TrueZen.nvim
              {:cmd :TZAtaraxis :config (load-file :truezen)})
(use-package! :norcalli/nvim-colorizer.lua
              {:config (load-file :colorizer) :event [:BufRead :BufNewFile]})
(use-package! :stevearc/dressing.nvim)
(use-package! :mcchrish/zenbones.nvim {:requires [(pack :rktjmp/lush.nvim)]})
(use-package! :metalelf0/jellybeans-nvim
              {:config (fn []
                         (vim.cmd "colorscheme jellybeans-nvim"))
               :requires [(pack :rktjmp/lush.nvim)]})

(use-package! :numToStr/Comment.nvim {:config (call-setup :Comment)})
(use-package! :phaazon/hop.nvim {:config (load-file :hop)})

(use-package! :itchyny/vim-haskell-indent {:ft [:haskell]})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)

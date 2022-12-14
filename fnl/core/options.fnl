(require-macros :macros.option-macros)

;; improve updatetime for quicker refresh + gitsigns
(set! updatetime 200)
(set! timeoutlen 500)

;; Show regex differences in a split
(set! inccommand :split)

;; Set shortmess
(set! shortmess :filnxtToOFatsIc)

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Disable swapfiles and enable undofiles
(set! undofile)
(set! noswapfile)

;;; UI-related options
(set! noruler)

;; Numbering
(set! number)

;; Smart search
(set! smartcase)

;; Case-insensitive search
(set! ignorecase)

;; Indentation rules
(set! copyindent)
(set! smartindent)
(set! preserveindent)

;; Indentation level
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)

;; Expand tabs
(set! expandtab)

;; Disable mode message
(set! noshowmode)

;; Enable cursorline/column
(set! cursorline)
(set! nocursorcolumn)

;; colors
(set! termguicolors)
(set! background :dark)

;; Automatic split locations
(set! splitright)
(set! splitbelow)

;; Scroll off
(set! scrolloff 8)

;; cmp options
(set! completeopt [:menu :menuone :preview :noinsert])

;; cmdhieght 0 is a nightly option
(fn nightly? []
   "Check if using Neovim nightly (0.8)"
   (let [nightly (vim.fn.has :nvim-0.8.0)]
     (= nightly 1)))

(if (= true (nightly?))
   (set! cmdheight 0))

(require-macros :macros.event-macros)

(local {: line} vim.fn)
(fn cmd! [...] (vim.cmd ...))

;; Resize splits when window is resized
(augroup! resize-splits-on-resize
          (autocmd! VimResized * "wincmd ="))

;; Restore cursor on exit
(augroup! restore-cursor-on-exit
          (autocmd! VimLeave * '(set! guicursor ["a:ver100-blinkon0"])))

;; Open file on its last cursor position
(augroup! open-file-on-last-position
          (autocmd! BufReadPost * '(if (and (> (line "'\"") 1)
                                            (<= (line "'\"") (line "$")))
                                     (cmd! "normal! g'\""))))

(local lsp (require :lspconfig))
(local {: set-lsp-keys!} (require :core.keymaps))

;;; Diagnostics configuration
(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false
           :update_in_insert true
           :severity_sort true
           :float {:show_header false}})
  (sign_define :DiagnosticSignError {:text "E" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn {:text "W" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo {:text "I" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint {:text "H" :texthl :DiagnosticSignHint}))

(fn on-attach [client bufnr]
  ;; set keymaps via which-key
  (set-lsp-keys! bufnr))

;; What should the lsp be demanded of? Normally this would
(local capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities.textDocument.completion.completionItem
     {:documentationFormat [:markdown :plaintext]
      :snippetSupport true
      :preselectSupport true
      :insertReplaceSupport true
      :labelDetailsSupport true
      :deprecatedSupport true
      :commitCharactersSupport true
      :tagSupport {:valueSet {1 1}}
      :resolveSupport {:properties [:documentation
                                    :detail
                                    :additionalTextEdits]}})

;;; Setup servers
(local defaults {:on_attach on-attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

;; for simple servers jsut add them to the list
(let [servers [:clojure_lsp
               :rust_analyzer
               :rnix
               :pyright
               :hls]]
  (each [_ server (ipairs servers)]
    ((. (. lsp server) :setup) defaults)))

;; for trickier servers you can change up the defaults
(lsp.sumneko_lua.setup {:on_attach on-attach
                        : capabilities
                        :settings {:Lua {:diagnostics {:globals {1 :vim}}
                                         :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                               (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}
                                                     :maxPreload 100000
                                                     :preloadFileSize 10000}}}})

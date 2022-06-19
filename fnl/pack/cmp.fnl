(local {: lazy-require!} (require :utils.lazy-require))

(local {: insert} table)
(local {: setup
        : mapping
        : visible
        : complete
        : select_next_item
        : select_prev_item
        :config {: compare : disable}
        :ItemField {:Kind kind :Abbr abbr :Menu menu}
        :SelectBehavior {:Insert insert-behavior :Select select-behavior}
        : event} (lazy-require! :cmp))

(local types (lazy-require! :cmp.types))
(local under-compare (lazy-require! :cmp-under-comparator))

(local {: lsp_expand : expand_or_jump : expand_or_jumpable : jump : jumpable} (lazy-require! :luasnip))

;;; Setup
(setup {:preselect types.cmp.PreselectMode.None
        :experimental {:ghost_text true}
        :snippet {:expand (fn [args]
                            (lsp_expand args.body))}
        :mapping {:<C-b> (mapping.scroll_docs -4)
                  :<C-f> (mapping.scroll_docs 4)
                  :<C-e> (mapping.abort)
                  :<Tab> (mapping (fn [fallback]
                                    (if (visible)
                                        (select_next_item)
                                        (expand_or_jumpable)
                                        (expand_or_jump)
                                        (fallback)))
                                  [:i :s :c])
                  :<S-Tab> (mapping (fn [fallback]
                                      (if (visible)
                                          (select_prev_item)
                                          (jumpable -1)
                                          (jump -1)
                                          (fallback)))
                                    [:i :s :c])
                  :<CR> (mapping.confirm)
                  :<C-CR> (mapping.confirm {:select true})}
        :sources [{:name :nvim_lsp}
                  {:name :luasnip}
                  {:name :path}
                  {:name :buffer}
                  {:name :conjure}
                  {:name :copilot}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}})

;; cmdline setup
(setup.cmdline ":"
               {:view {:entries {:name :wildmenu
                                 :separator :|}}
                :sources [{:name :path} {:name :cmdline}]})

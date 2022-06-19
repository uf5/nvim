(local {: lazy-require!} (require :utils.lazy-require))

(local {: config} (lazy-require! :luasnip))

(config.set_config {:history true :updateevents "TextChanged,TextChangedI"})

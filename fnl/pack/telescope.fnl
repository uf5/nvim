(local {: lazy-require!} (require :utils.lazy-require))
(local {: setup : load_extension} (lazy-require! :telescope))

(setup {:defaults {}})

;; Load extensions
(load_extension :fzf)
(load_extension :project)

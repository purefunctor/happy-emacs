;;; happy-haskell.el --- Haskell configuration for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Haskell configuration for ハッピ Emacs
;;
;;; Code:

(setup (:recipe 'haskell-mode)
  (:with-feature haskell-mode
    (:hook #'lsp)))

(setup (:recipe 'lsp-haskell)
  (:require lsp-haskell))

(provide 'happy-haskell)

;;; happy-haskell.el ends here

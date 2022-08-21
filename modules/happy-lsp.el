;;; happy-lsp.el --- LSP configuration for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; LSP configuration for ハッピ Emacs
;;
;;; Code:

(setup (:recipe 'yasnippet)
  (:with-mode yas-minor-mode
    (:hook-into prog-mode)))

(setup (:recipe 'lsp-mode)
  (:option lsp-enable-symbol-highlighting nil
           lsp-headerline-breadcrumb-enable nil
           lsp-modeline-code-actions-enable nil
           lsp-modeline-diagnositcs-enable nil))

(provide 'happy-lsp)

;;; happy-lsp.el ends here

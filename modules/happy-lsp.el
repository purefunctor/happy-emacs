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

(defun happy/lsp-setup-completion ()
  "Setup `lsp-completion-mode'."
  (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults)) '(substring)))

(setup (:recipe 'lsp-mode)
  (:option lsp-enable-symbol-highlighting nil
           lsp-headerline-breadcrumb-enable nil
           lsp-modeline-code-actions-enable nil
           lsp-modeline-diagnositcs-enable nil
           lsp-completion-provider :none)
  (:with-mode lsp-completion-mode
    (:hook happy/lsp-setup-completion)))

(provide 'happy-lsp)

;;; happy-lsp.el ends here

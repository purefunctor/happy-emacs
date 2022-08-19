;;; happy-minibuffer.el --- Minibuffer configuration for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Minibuffer configuration for ハッピ Emacs
;;
;;; Code:

(setup (:recipe '(vertico :files ("*" "extensions/*" (:exclude ".git"))))
  (:require vertico)
  (vertico-mode))

(setup (:recipe 'orderless)
  (:require orderless)
  (add-to-list 'completion-styles 'orderless))

(setup (:recipe 'marginalia)
  (:require marginalia)
  (marginalia-mode))

(provide 'happy-minibuffer)

;;; happy-minibuffer.el ends here

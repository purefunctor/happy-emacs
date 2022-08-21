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

(setup (:recipe 'corfu)
  (:require corfu)
  (:option corfu-auto t)
  (:with-mode corfu-mode
    (:hook-into prog-mode)))

(setup (:recipe 'corfu-doc)
  (:require corfu-doc)
  (:with-mode corfu-doc-mode
    (:hook-into corfu-mode)))

(setup (:recipe 'kind-icon)
  (:require kind-icon)
  (:option kind-icon-default-face 'corfu-default
           kind-icon-blend-background nil)
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'happy-minibuffer)

;;; happy-minibuffer.el ends here

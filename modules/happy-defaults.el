;;; happy-defaults.el --- Defaults for ハッピ Emacs.  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Defaults for ハッピ Emacs.
;;
;;; Code:

(setq-default
  ;; whatever I feel like
  cursor-type 'box
  ;; less jitter when scrolling
  display-line-numbers-width 3
  ;; prefer tabs over spaces
  indent-tabs-mode nil
  ;; render tabs as 4 spaces
  tab-width 4)

(setq
  ;; temporary files
  auto-save-file-name-transforms `((".*" ,happy-saves))
  backup-directory-alist `((".*" . ,happy-saves))
  ;; for resizing on MacOS
  frame-resize-pixelwise t
  ;; overall performance
  gc-cons-threshold (* 8 1024 1024)
  ;; for quitting C-h faster
  help-window-select t
  ;; drop into *scratch*
  inhibit-startup-message t
  ;; lsp performance
  read-process-output-max (* 8 1024 1024)
  ;; standard, but opinionated
  require-final-newline t)

;; load customizations only if they exist
(setq custom-file happy-custom)
(if (file-exists-p custom-file) (load custom-file))

;; fonts
(dolist (face '(default fixed-pitch variable-pitch))
  (custom-set-faces
   `(,face ((t (:family "FantasqueSansMono Nerd Font" :height 140))))))

;; modes
(column-number-mode)

(unless (version< emacs-version "29")
  (pixel-scroll-precision-mode))

(add-hook 'prog-mode-hook #'auto-revert-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

(provide 'happy-defaults)

;;; happy-defaults.el ends here

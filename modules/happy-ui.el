;;; happy-ui.el --- UI for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; UI for ハッピ Emacs
;;
;;; Code:

(setup (:recipe 'all-the-icons)
  (:when (display-graphic-p)
         (:require all-the-icons)))

(setup (:recipe 'dashboard)
  (:require dashboard)
  (:option dashboard-banner-logo-title "ハッピ Emacs"
           dashboard-center-content t
           dashboard-startup-banner (expand-file-name "logo.png" user-emacs-directory))
  (dashboard-setup-startup-hook))

(setup (:recipe 'diredfl)
  (:require diredfl)
  (:with-mode dired-mode
    (:hook diredfl-global-mode)))

(setup (:recipe 'doom-modeline)
  (:require doom-modeline)
  (doom-modeline-mode))

(setup (:recipe 'doom-themes)
  (:require doom-themes)
  (load-theme 'doom-ayu-mirage t))

(defun happy/popper-fit-window-height (win)
  "Make `popper' fill half of the window height at most."
  (fit-window-to-buffer win (floor (frame-height) 2) (floor (frame-height) 2)))

(setup (:recipe 'popper)
  (:require popper)
  (:option popper-reference-buffers
           '("\\*Messages\\*"
             "Output\\*$"
             "\\*Async Shell Command\\*"
             help-mode
             compilation-mode
             "\\*vterm\\*"
             "\\*Checkdoc Status\\*")
           popper-window-height #'happy/popper-fit-window-height)
  (popper-mode)
  (popper-echo-mode))

(provide 'happy-ui)

;;; happy-ui.el ends here

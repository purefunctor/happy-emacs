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

(provide 'happy-ui)

;;; happy-ui.el ends here

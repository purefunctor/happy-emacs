;;; happy-org.el --- Org configuration for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Org configuration for ハッピ Emacs
;;
;;; Code:

(defconst happy-org-directory (expand-file-name "agenda" happy-org-root)
  "The folder used for `org-agenda'.")

(defconst happy-org-roam-directory (expand-file-name "roam" happy-org-root)
  "The folder used for `org-roam'.")

(setup (:recipe 'org)
  (:require org)
  (:option org-directory happy-org-directory
           org-agenda-files (list org-directory))
  (:with-mode org-mode
    (:hook org-indent-mode variable-pitch-mode visual-line-mode)))

(setup (:recipe 'org-roam)
  (:require org-roam)
  (:option org-roam-directory happy-org-roam-directory
           org-roam-completion-everywhere t)
  (org-roam-db-autosync-mode))

(provide 'happy-org)

;;; happy-org.el ends here

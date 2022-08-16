;;; happy-magit.el --- Magit configuration for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Magit configuration for ハッピ Emacs
;;
;;; Code:

(defun happy/git-commit-fill-column ()
  "Set the `fill-column' when editing the commit message."
  (setq-local fill-column 72))

(setup (:recipe 'magit)
  (:require magit)
  (:option git-commit-summary-max-length 50)
  (:with-mode git-commit-mode
    (:hook happy/git-commit-fill-column)))

(provide 'happy-magit)

;;; happy-magit.el ends here

;;; happy-term.el --- Terminal emulator configuration for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Terminal emulator configuration for ハッピ Emacs
;;
;;; Code:

(setup (:recipe 'vterm))

(defun happy/project-vterm ()
  "Open a `vterm' terminal on the project root."
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (vterm-other-window)))

(define-key project-prefix-map (kbd "t") #'happy/project-vterm)

(provide 'happy-term)

;;; happy-term.el ends here

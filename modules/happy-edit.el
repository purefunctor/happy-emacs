;;; happy-edit.el --- Text editing for ハッピ Emacs  -*- lexical-binding: t -*-
;;
;;; Commentary:
;;
;; Text editing for ハッピ Emacs
;;
;;; Code:

(setup (:recipe 'ws-butler)
  (:with-mode ws-butler-mode
    (:hook-into prog-mode)))

(provide 'happy-edit)

;;; happy-edit.el ends here

;;; happy-hydra.el --- Hydra definitions for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Hydra definitions for ハッピ Emacs
;;
;;; Code:

(setup (:recipe 'hydra)
  (:require hydra))

(defhydra org-hydra (:color blue :hint nil)
  "

  org-hydra

  _s_ : org-schedule
  _,_ : org-insert-structure-template

  _q_ : keyboard-quit
  "
  ("s" org-schedule)
  ("," org-insert-structure-template)
  ("q" keyboard-quit))

(defhydra roam-hydra (:hint nil)
  "

  roam-hydra

  _f_ : org-roam-node-find
  _i_ : org-roam-node-insert
  _t_ : org-roam-tag-add

  _q_ : keyboard-quit
  "

  ("f" org-roam-node-find :exit t)
  ("i" org-roam-node-insert :exit t)
  ("t" org-roam-tag-add :exit t)
  ("q" keyboard-quit :exit t))

(define-key org-mode-map (kbd "C-c o") 'org-hydra/body)
(define-key global-map (kbd "C-c n") 'roam-hydra/body)

(provide 'happy-hydra)

;;; happy-hydra.el ends here

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

(defun happy/kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun happy/hydra-no-switch ()
  "Inform the user that the hydra wasn't switched."
  (interactive)
  (message "Already within '%s'." hydra-curr-body-fn))

(defhydra tab-hydra (:hint nil)
  "

  tab-hydra

  _j_ : awesome-tab-forward         _k_ : awesome-tab-backward
  _h_ : awesome-tab-backward-group  _l_ : awesome-tab-forward-group

  _x_ : happy/kill-current-buffer

  _q_ : keyboard-quit  _w_ : window-hydra
  "
  ("k" awesome-tab-backward)
  ("h" awesome-tab-backward-group)
  ("j" awesome-tab-forward)
  ("l" awesome-tab-forward-group)
  ("x" happy/kill-current-buffer)
  ("q" keyboard-quit :exit t)
  ("w" window-hydra/body :exit t)
  ("t" happy/hydra-no-switch))

(defvar happy/window-horizontal t
  "Whether or not to resize horizontally.")

(defun happy/split-window-vertical ()
  "Split the current window vertically."
  (interactive)
  (let ((window (get-buffer-window)))
    (select-window window)
    (split-window-vertically)
    (windmove-down window)))

(defun happy/split-window-horizontal ()
  "Split the current window horizontally."
  (interactive)
  (let ((window (get-buffer-window)))
    (select-window window)
    (split-window-horizontally)
    (windmove-right window)))

(defun happy/window-horizontal ()
  "Toggle the mode of the window resizing functions."
  (interactive)
  (setq happy/window-horizontal (not happy/window-horizontal)))

(defun happy/window-shrink ()
  "Shrink the current window."
  (interactive)
  (window-resize (get-buffer-window) (- 2) happy/window-horizontal))

(defun happy/window-grow ()
  "Grow the current window."
  (interactive)
  (window-resize (get-buffer-window) (+ 2) happy/window-horizontal))

(defun happy/window-balance ()
  "Balance the windows."
  (interactive)
  (balance-windows))

(defhydra window-hydra (:hint nil)
  "

  window-hydra

  _j_ : windmove-down  _k_ : windmove-up     _v_ : happy/split-window-vertical
  _h_ : windmove-left  _l_ : windmove-right  _b_ : happy/split-window-horizontal

  _,_ : happy/window-shrink  _=_ : happy/window-balance
  _._ : happy/window-grow    _/_ : happy/window-horizontal [ %`happy/window-horizontal ]

  _x_ : delete-window

  _q_ : keyboard-quit  _t_ : tab-hydra
  "
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("h" windmove-left)
  ("v" happy/split-window-vertical)
  ("b" happy/split-window-horizontal)
  ("x" delete-window)
  ("q" keyboard-quit :exit t)
  ("t" tab-hydra/body :exit t)
  ("w" happy/hydra-no-switch)
  ("," happy/window-shrink)
  ("." happy/window-grow)
  ("/" happy/window-horizontal)
  ("=" happy/window-balance :exit t))

(define-key org-mode-map (kbd "C-c o") 'org-hydra/body)
(define-key global-map (kbd "C-c n") 'roam-hydra/body)
(define-key global-map (kbd "C-c t") 'tab-hydra/body)
(define-key global-map (kbd "C-c w") 'window-hydra/body)

(provide 'happy-hydra)

;;; happy-hydra.el ends here

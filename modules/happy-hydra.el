;;; happy-hydra.el --- Hydra definitions for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Hydra definitions for ハッピ Emacs
;;
;;; Code:

(defun happy/kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun happy/split-window-vertical ()
  "Split the current window vertically."
  (interactive)
  (let ((window (get-buffer-window)))
    (aw-split-window-vert window)
    (windmove-down window)))

(defun happy/split-window-horizontal ()
  "Split the current window horizontally."
  (interactive)
  (let ((window (get-buffer-window)))
    (aw-split-window-horz window)
    (windmove-right window)))

(defun happy/hydra-no-switch ()
  "Inform the user that the hydra wasn't switched."
  (interactive)
  (message "Already within '%s'." hydra-curr-body-fn))

(defun happy/window-shrink-horizontal ()
  "Shrink the window horizontally."
  (interactive)
  (window-resize (get-buffer-window) (- 5) t))

(defun happy/window-grow-horizontal ()
  "Grow the window horizontally."
  (interactive)
  (window-resize (get-buffer-window) (+ 5) t))

(defun happy/window-shrink-vertical ()
  "Shrink the window vertically."
  (interactive)
  (window-resize (get-buffer-window) (- 5)))

(defun happy/window-grow-vertical ()
  "Grow the window vertically."
  (interactive)
  (window-resize (get-buffer-window) (+ 5)))

(defun happy/window-balance ()
  "Balance the windows."
  (interactive)
  (balance-windows))

(setup (:recipe 'hydra)
  (:require hydra))

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

(defhydra window-hydra (:hint nil)
  "

  window-hydra

  _j_ : windmove-down  _k_ : windmove-up     _v_ : happy/split-window-vertical
  _h_ : windmove-left  _l_ : windmove-right  _b_ : happy/split-window-horizontal

  _,_ : happy/window-shrink-horizontal  _-_ : happy/window-shrink-vertical  _=_ : happy/window-balance
  _._ : happy/window-grow-horizontal    _+_ : happy/window-grow-vertical

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
  ("," happy/window-shrink-horizontal)
  ("." happy/window-grow-horizontal)
  ("-" happy/window-shrink-vertical)
  ("+" happy/window-grow-vertical)
  ("=" happy/window-balance))

(define-key global-map (kbd "C-c t") 'tab-hydra/body)
(define-key global-map (kbd "C-c w") 'window-hydra/body)

(provide 'happy-hydra)

;;; happy-hydra.el ends here

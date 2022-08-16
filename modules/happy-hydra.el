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
  ("w" happy/hydra-no-switch))

(define-key global-map (kbd "C-c t") 'tab-hydra/body)
(define-key global-map (kbd "C-c w") 'window-hydra/body)

(provide 'happy-hydra)

;;; happy-hydra.el ends here

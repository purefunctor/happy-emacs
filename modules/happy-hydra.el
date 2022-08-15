;;; happy-hydra.el --- Hydra definitions for ハッピ Emacs  -*- lexical-binding: t -*-
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

(defhydra tab-hydra (:hint nil)
  "

  tab-hydra

  _j_ : awesome-tab-forward        _k_ : awesome-tab-backward
  _J_ : awesome-tab-forward-group  _K_ : awesome-tab-backward-group

  _x_ : happy/kill-current-buffer  _q_ : keyboard-quit
  "
  ("k" awesome-tab-backward)
  ("K" awesome-tab-backward-group)
  ("j" awesome-tab-forward)
  ("J" awesome-tab-forward-group)
  ("x" happy/kill-current-buffer)
  ("q" keyboard-quit :exit t))

(defhydra window-hydra (:hint nil)
  "

  window-hydra

  _j_ : windmove-down  _l_ : windmove-right  _v_ : happy/split-window-vertical
  _k_ : windmove-up    _h_ : windmove-left   _b_ : happy/split-window-horizontal

  _x_ : delete-window  _q_ : keyboard-quit
  "
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("h" windmove-left)
  ("v" happy/split-window-vertical)
  ("b" happy/split-window-horizontal)
  ("x" delete-window)
  ("q" keyboard-quit :exit t))

(define-key global-map (kbd "C-x t") 'tab-hydra/body)
(define-key global-map (kbd "C-x w") 'window-hydra/body)

(provide 'happy-hydra)

;;; happy-hydra.el ends here

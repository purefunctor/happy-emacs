;;; init.el --- ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; ハッピ Emacs is a minimal Emacs distribution.
;;
;;; Code:

(defconst happy-modules
  (expand-file-name "modules" user-emacs-directory)
  "The folder where ハッピ Emacs modules are stored.")

(defconst happy-custom
  (expand-file-name "custom.el" user-emacs-directory)
  "The file where customizations are stored.")

(defconst happy-saves
  (expand-file-name "saves" user-emacs-directory)
  "The folder where automatic save files are stored.")

(defcustom happy-org-root "~/org"
  "The folder to be used for `org-mode' related files.")

;; straight.el/setup.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'setup)

;; load modules
(push happy-modules load-path)
(require 'happy-defaults)
(require 'happy-setup)
(require 'happy-edit)
(require 'happy-ui)
(require 'happy-minibuffer)
(require 'happy-magit)
(require 'happy-org)
(require 'happy-lsp)
(require 'happy-rust)
(require 'happy-hydra)

;;; init.el ends here

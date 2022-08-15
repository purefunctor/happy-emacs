;;; happy-setup.el --- setup.el macros for ハッピ Emacs  -*- lexical-binding: t -*-
;;
;;; Commentary:
;;
;; setup.el macros for ハッピ Emacs
;;
;;; Code:

(require 'setup)

(setup-define :recipe
  (lambda (recipe)
    `(straight-use-package ,recipe))
  :documentation "Provide a RECIPE to `straight-use-package'.")

(setup-define :when
  (lambda (condition &rest body)
    `(when ,condition ,@body))
  :documentation "Evaluates BODY when the condition evaluates to `t'.")

(setup-define :unless
  (lambda (condition &rest body)
    `(unless ,condition ,@body))
  :documentation "Evaluates BODY unless the condition evaluates to `t'.")

(provide 'happy-setup)

;;; happy-setup.el ends here

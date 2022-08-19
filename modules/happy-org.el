;;; happy-org.el --- Org configuration for ハッピ Emacs  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; Org configuration for ハッピ Emacs
;;
;;; Code:

(defconst happy-org-directory (expand-file-name "agenda" happy-org-root)
  "The folder used for `org-agenda'.")

(defconst happy-org-roam-directory (expand-file-name "roam" happy-org-root)
  "The folder used for `org-roam'.")

(setup (:recipe 'org)
  (:require org)
  (:option org-directory happy-org-directory
           org-agenda-files (list org-directory))
  (:with-mode org-mode
    (:hook org-indent-mode variable-pitch-mode visual-line-mode)))

(setup (:recipe 'org-roam)
  (:require org-roam)
  (:option org-roam-directory happy-org-roam-directory
           org-roam-completion-everywhere t
           org-roam-node-display-template #'happy/org-roam-node-display-template)
  (org-roam-db-autosync-mode))

(setup (:recipe 'visual-fill-column)
  (:require visual-fill-column)
  (:option visual-fill-column-center-text t
           visual-fill-column-width 120)
  (:with-mode visual-fill-column-mode
    (:hook-into org-mode)))

(defun happy/org-roam-longest-title-length ()
  "Find the length of the node with the longest title."
  (+ 1 (seq-max (seq-map (lambda (x) (string-width (car x)))
                         (org-roam-db-query [:select title :from nodes])))))

(cl-defmethod org-roam-node-parent ((node org-roam-node))
  "Get the title of a NODE's parent NODE."
  (let ((parent-title
         (org-roam-db-query
          [:select title :from nodes :where (= file $s1) :and (= level 0)] (org-roam-node-file node))))
    (car (car parent-title))))

(defun happy/org-roam-node-display-template ()
  "Generate the `org-roam-node-display-template'."
  (let ((longest-title (happy/org-roam-longest-title-length)))
    (concat (propertize (format "${parent:%i}" longest-title) 'face 'org-cite)
            "| "
            (format "${title:%i}" longest-title)
            "| "
            (propertize "${tags:20}" 'face 'org-tag))))

(provide 'happy-org)

;;; happy-org.el ends here

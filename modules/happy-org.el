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

(defconst happy-org-hugo-directory (expand-file-name "site" happy-org-root)
  "The folder used for `ox-hugo'.")

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

(defconst happy/org-roam-longest-title-length-default 20
  "The default value yielded by `happy/org-roam-longest-title-length'.")

(defun happy/org-roam-longest-title-length ()
  "Find the length of the node with the longest title."
  (let ((title-lengths
         (seq-map (lambda (x) (string-width (car x)))
                  (org-roam-db-query [:select title :from nodes]))))
    (+ 1 (if (seq-empty-p title-lengths)
             happy/org-roam-longest-title-length-default
           (seq-max title-lengths)))))

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

(setup (:recipe 'ox-hugo)
  (:require ox-hugo)
  (:option org-hugo-base-dir happy-org-hugo-directory))

(defun happy/ox-hugo-publish-posts ()
  "Publish `org-roam' nodes marked with `blog-post'."
  (interactive)
  (message "Starting export...")
  (let ((nodes (org-roam-db-query [:select file :from [nodes, tags] :where (= node_id id) :and (= tag "blog-post")])))
    (dolist (node nodes)
      (let* ((file (car node))
             (visiting (null (get-file-buffer file)))
             (buffer (find-file-noselect file)))
        (message "Exporting %s" file)
        (with-current-buffer buffer
          (let ((inhibit-message t))
            (org-hugo-export-to-md)))
        (when visiting
          (kill-buffer buffer)))))
  (message "Finished export..."))

(provide 'happy-org)

;;; happy-org.el ends here

;;; -*- lexical-binding: t -*-
(provide 'js-custom)

(require 'js-comint)
(setq inferior-js-program-command "node --interactive")

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(require 'js2-mode)
(require 'js2-refactor)

(add-hook 'js2-mode-hook 
	  (lambda ()
	    (require 'js2-refactor)
            (require 'git-gutter)
            (setq-local tab-width 2)
            (local-set-key (kbd "C-c c") 'js--goto-class-file)
            (git-gutter-mode +1)))

(defun js--goto-class-file ()
  (interactive)

  (defun class-name->file-path (name)
    (let* ((parts (split-string name "\\."))
           (path (mapconcat 'identity parts "\/")))
      (format "%s.js" path)))

  (defun class-name-at-point ()
    (if (js2r--point-inside-string-p)
        (substring (js2-node-string (js2-node-at-point))
                   1 -1)))
  
  (defun project-root (file)
    (locate-dominating-file 
     file
     (lambda (dir)
          (or
           (find "Content" (directory-files dir)
                 :test 'equal)
           (and
            (find "shared" (directory-files dir)
                  :test 'equal)
            (find "local" (directory-files dir)
                  :test 'equal))))))

  (let* ((file (buffer-file-name (current-buffer)))
         (root (and file (project-root file))))
    (if root
        (let* ((class (class-name-at-point))
               (path  (and class (class-name->file-path class)))
               (files* (mapcar (lambda (f)
                                 (format "%s%s/%s" root f path))
                               '("local" "shared" "Content")))
               (files (remove-if-not 'file-exists-p files*)))

          (if files 
              (find-file (first files))
            (princ (format "File not found %s" path))))
      (princ (format "couldn't get file from: %s" (current-buffer))))))


;; After js2 has parsed a js file, we look for jslint globals decl comment ("/* global Fred, _, Harry */") and
;; add any symbols to a buffer-local var of acceptable global vars
;; Note that we also support the "symbol: true" way of specifying names via a hack (remove any ":true"
;; to make it look like a plain decl, and any ':false' are left behind so they'll effectively be ignored as
;; you can't have a symbol called "someName:false"
(add-hook 'js2-post-parse-callbacks
          (lambda ()
            (when (> (buffer-size) 0)
              (let ((btext (replace-regexp-in-string
                            ": *true" " "
                            (replace-regexp-in-string "[\n\t ]+" " " (buffer-substring-no-properties 1 (buffer-size)) t t))))
                (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                      (split-string
                       (if (string-match "/\\* *global *\\(.*?\\) *\\*/" btext) (match-string-no-properties 1 btext) "")
                       " *, *" t))
                ))))


(defun json--tidy-region (start end)
  (interactive "r")
  (shell-command-on-region
   start end (concat python-command " -mjson.tool")
   nil t))

;;; -*- lexical-binding: t -*-
(provide 'sass-custom)

(autoload 'sass-mode "sass-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(add-hook 'sass-mode-hook 
          (lambda ()
            (defun compass-compile-hook ()
              (if (and (buffer-file-name) 
                       (file-name-extension (buffer-file-name)))
                  (let* ((filename (buffer-file-name))
                         (suffix (downcase (file-name-extension filename))))
                    (if (and filename (string= suffix "scss"))
                        (compass-compile-project)))))
            (add-hook 'after-save-hook 'compass-compile-hook)))

(defun compass-compile-project ()
  "Search the file-tree up from the current file looking for config.rb
and run compass from that directory"
  (interactive)
  (let* ((sass-file (buffer-file-name (current-buffer)))
         (local-dir (file-name-directory sass-file)))
    (flet ((contains-config-rb (dir-name)
                               (find "config.rb" (directory-files dir-name)
                                     :test 'equal))
           (parent-dir (dir)
                       (expand-file-name 
                        (file-name-as-directory (concat 
                                                 (file-name-as-directory dir) 
                                                 ".."))))
           (get-root (d)
                     (cond ((contains-config-rb d) d)
                           ((equal (parent-dir d) d) nil)
                           ((get-root (parent-dir d)))))

           (run-compass (dir)
                        (let ((default-directory dir))
                          (start-file-process "compass"
                                              "*compass-process*"
                                              "compass"
                                              "compile"))))
      (let (( dir (get-root local-dir)))
        (if dir
            (run-compass dir)
          (princ (format "no config from %s" local-dir)))))))


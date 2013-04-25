(require 'package)
(provide 'package-custom)

(add-to-list 'package-archives 
    '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defun require-packages (packages)
  (let ((pending (remove-if 'package-installed-p packages)))
    (when pending
      (package-refresh-contents)
      (dolist (pkg pending)
        (package-install pkg)))))

(require-packages '(
      org htmlize 
      sass-mode projectile paredit magit 
      json-mode js2-refactor js2-mode js-comint ac-js2

      git-gutter magit

      dired-details dired-details+
      color-theme-blackboard color-theme 

      coffee-mode auto-complete))


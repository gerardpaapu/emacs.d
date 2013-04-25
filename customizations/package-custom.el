(require 'package)
(provide 'package-custom)

(add-to-list 'package-archives 
    '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; TODO: separate these out into the customization files
(setq required-packages '(
      sass-mode projectile paredit org magit 
      json-mode js2-refactor js2-mode js-comint ac-js2
      org htmlize 
      git-gutter magit

      dired-details dired-details+
      color-theme-blackboard color-theme 

      coffee-mode auto-complete))

(dolist (pkg required-packages)
  (if (not (package-installed-p pkg))
      (package-install pkg)))

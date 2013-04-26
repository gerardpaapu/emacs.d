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

;; TODO: split this into the customization modules, so that they're
;; each requiring their own packages
(require-packages '(
      projectile
      dired-details dired-details+
      color-theme
      color-theme-blackboard
      auto-complete))


;;; -*- lexical-binding: t -*- 
(require 'package)
(provide 'package-custom)

(add-to-list 'package-archives 
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defun require-packages (packages)
  (defun -package-installed-p (package &optional version)
    "true if the package is installed and is at-least this version"
    (let ((pkg (find-if (lambda (pkg)
                          (equal (car pkg) package))
                        package-alist)))
      (if pkg 
          (if (not version)
              t
            (let ((installed-v  (aref (cdr pkg) 0)))
              (if installed-v (>= (car installed-v) version)))))))
  
  (defun -satisfied-p (descriptor)
    (if (listp descriptor)
        (let ((name (first descriptor))
              (version (second descriptor)))
          (-package-installed-p name version))
        (-package-installed-p descriptor)))


  (let ((pending (mapcar
		  (lambda (ls) (if (listp ls) (car ls) ls))
		  (remove-if '-satisfied-p
			     packages))))
    (when pending
      (package-refresh-contents)
      (dolist (pkg pending)
        (package-install pkg)))))


(require-packages '(
                    projectile
                    dired-details dired-details+
                    color-theme
                    color-theme-blackboard
                    auto-complete))


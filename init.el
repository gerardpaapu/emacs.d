(require 'cl)

(case system-type
  ('darwin 
   (load-file (concat user-emacs-directory "platform/os-x.el")))
  ('windows-nt 
   (load-file (concat user-emacs-directory "platform/win-32.el"))))

;; Store customizations in a file that we version
(setq custom-file "~/.emacs.d/customs.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/customizations")
(require 'package-custom)
(require 'git-custom)
(require 'sass-custom)
(require 'js-custom)
(require 'org-custom)
(require 'lisp-custom)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;; Steve Yegge's key bindings
;;; https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-xm" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; I guess I hate tool-bars
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; I also hate tabs
(setq-default indent-tabs-mode nil)

;; I also hate bells to death
(setq ring-bell-function (lambda () nil))
(setq visible-bell 't)


(add-to-list 'auto-mode-alist '("\\.cshtml" . html-mode))


(when (display-graphic-p)
  (require 'color-theme-blackboard)
  (color-theme-initialize)
  (color-theme-blackboard)) 

(require 'projectile)
(projectile-global-mode +1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(put 'narrow-to-region 'disabled nil)

(require 'dired-details)
(require 'dired-details+)

(server-start)

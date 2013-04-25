(provide 'lisp-custom)

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(dolist (mode-hook '(emacs-lisp-mode-hook
                     lisp-mode-hook
                     lisp-interaction-mode-hook
                     scheme-mode-hook))
  (add-hook mode-hook
            (lambda ()
              (paredit-mode +1)
              (show-paren-mode +1))))

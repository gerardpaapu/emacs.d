(require 'org)
(provide 'org-custom)
(setq org-agenda-files (list (concat shared-folder "projects")))

(global-set-key (kbd "C-c t") 'org-todo-list)

(setq org-todo-keywords 
      '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))

(add-hook 'org-mode-hook (lambda () (auto-fill-mode +1)))

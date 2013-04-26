;;; -*- lexical-binding: t -*-
(provide 'git-custom)
(require-packages '(magit git-gutter))

(require 'magit)
(global-set-key (kbd "C-c m") 'magit-status)
(add-hook 'magit-log-edit-mode-hook 
          (lambda () (auto-fill-mode +1)))

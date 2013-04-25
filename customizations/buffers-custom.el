(provide 'buffers-custom)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(defadvice ibuffer
  (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to the most recent buffer name"
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

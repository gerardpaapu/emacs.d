(setq python-command "/usr/bin/python")
(setq shared-folder "~/Dropbox")

(set-face-attribute 'default nil :family "Monaco")

;; default font size (point * 10)
;;
;; WARNING!  Depending on the default font,
;; if the size is not supported very well, the frame will be clipped
;; so that the beginning of the buffer may not be visible correctly. 
(set-face-attribute 'default nil :height 160)

;; use specific font for Korean charset.
;; if you want to use different font size for specific charset,
;; add :size POINT-SIZE in the font-spec.
(set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))

;; you may want to add different for other charset in this way.

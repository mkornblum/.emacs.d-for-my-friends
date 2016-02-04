(setq custom-file "~/.emacs.d/my/my-customizations.el"
      inferior-lisp-program "clisp -K full"
      tramp-default-method "ssh"
      ido-enable-flex-matching t
      org-log-done t
      require-trailing-newline t
      x-select-enable-clipboard t
      inhibit-startup-message t
      backup-directory-alist '(("." . "~/.emacs.d/.backups"))
      echo-keystrokes 0.1
      next-line-add-newlines nil
      recentf-max-saved-items 999
      column-number-mode t
      ido-max-directory-size 100000
      magit-completing-read 'ido-completing-read
      magit-refresh-status-buffer nil
      font-lock-maximum-decoration t)

(setq-default kill-read-only-ok t
              indent-tabs-mode nil)

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint json-jsonlist)))

(flycheck-add-mode 'javascript-eslint 'web-mode)

(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))
;; allows files to be opened like:
;; /sudo:root@host:

(fset 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(load custom-file)

(provide 'my-settings)

;; HOOKS

(defmacro hook-if (hook predicate &rest body)
  `(add-hook ,hook (lambda ()
                     (if ,predicate
                         (progn
                           ,@body)))))

(defmacro hook-unless (hook predicate &rest body)
  `(hook-if ,hook (not ,predicate) ,@body))

(defun major-mode-match-p (mode)
  (string-match mode (symbol-name major-mode)))

(hook-unless 'find-file-hook (major-mode-match-p "makefile") (untabify-all))
(hook-unless 'find-file-hook buffer-read-only (delete-trailing-whitespace))
(hook-unless 'before-save-hook (major-mode-match-p "makefile") (untabify-all))
(hook-unless 'before-save-hook (major-mode-match-p "markdown") (delete-trailing-whitespace))
(add-hook
 'before-save-hook
 (lambda ()
   (auto-make-directory)
   (tide-format-before-save)
   ))
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook
 'magit-status-mode-hook
 (lambda ()
   (define-key magit-mode-map (kbd "Z") 'magit-quick-stash)))

(add-hook
 'dired-mode-hook
 (lambda ()
   (define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory)
   (define-key dired-mode-map (kbd "e") 'dired-efap)))

(add-hook
 'ruby-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)
   (rvm-activate-corresponding-ruby)
   (flycheck-mode)))

(add-hook
 'javascript-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)
   (add-node-modules-path)
   (eslintd-fix-mode)
   (flycheck-mode)))

(add-hook
 'js-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)
   (add-node-modules-path)
   (eslintd-fix-mode)
   (flycheck-mode)))

(add-hook
 'js2-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)
   (local-unset-key (kbd "M-j"))
   (add-node-modules-path)
   (eslintd-fix-mode)
   (flycheck-mode 1)))

(add-hook
 'coffee-mode-hook
 (lambda ()
   (smart-indent-rigidly-mode)))

(add-hook
 'sass-mode-hook
 (lambda ()
   (smart-indent-rigidly-mode)
   (flycheck-mode)))

(add-hook
 'haml-mode-hook
 (lambda ()
   (smart-indent-rigidly-mode)))

(add-hook
 'css-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)))

(add-hook
 'magit-log-edit-mode-hook
 (lambda ()
   (flyspell-mode)
   (set-fill-column 72)))

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   (linum-mode)
   (paredit-mode +1)))

(add-hook
 'lisp-interaction-mode-hook
 (lambda ()
   (paredit-mode +1)))

(add-hook
 'slime-repl-mode-hook
 (lambda ()
   (paredit-mode +1)))

(add-hook
 'web-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)
   (auto-complete-mode)
   (add-node-modules-path)
   (flycheck-mode 1)
   (eslintd-fix-mode)
   (when (string-equal "tsx" (file-name-extension buffer-file-name))
     (setup-tide-mode))))

(add-hook
 'typescript-mode-hook
 (lambda ()
   (flycheck-mode 1)
   (prettier-js-mode)
   (setup-tide-mode)))

(add-hook
 'rjsx-mode-hook
 (lambda ()
   (auto-indent-mode)
   (linum-mode)
   (auto-complete-mode)
   (add-node-modules-path)
   (flycheck-mode 1)
   (eslintd-fix-mode)))

(provide 'my-hooks)

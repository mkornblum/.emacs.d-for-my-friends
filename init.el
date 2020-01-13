(let ((default-directory  "~/.emacs.d/"))
  (setq load-path
        (append
         (let ((load-path  (copy-sequence load-path))) ;; Shadow
           (append
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defmacro hook-if (hook predicate &rest body)
  `(add-hook ,hook (lambda ()
                     (if ,predicate
                         (progn
                           ,@body)))))

(defmacro hook-unless (hook predicate &rest body)
  `(hook-if ,hook (not ,predicate) ,@body))

(defun major-mode-match-p (mode)
  (string-match mode (symbol-name major-mode)))

;; (hook-unless 'find-file-hook (major-mode-match-p "makefile") (untabify-all))
;; (hook-unless 'find-file-hook (major-mode-match-p "java") (untabify-all))
;; (hook-unless 'find-file-hook buffer-read-only (delete-trailing-whitespace))
;; (hook-unless 'before-save-hook (major-mode-match-p "makefile") (untabify-all))
;; (hook-unless 'before-save-hook (major-mode-match-p "java") (untabify-all))
;; (hook-unless 'before-save-hook (major-mode-match-p "markdown") (delete-trailing-whitespace))

(use-package my-functions)
(use-package my-keybindings)
(use-package delight
  :ensure t
  :pin gnu)

(use-package add-node-modules-path
  :hook ((web-mode . add-node-modules-path)))
;;          (typescript-mode . add-node-modules-path)
;;          (rjsx-mode . add-node-modules-path)
;;          (js2-mode . add-node-modules-path)))
(use-package auto-complete)
(use-package avy)
(use-package auto-indent-mode)
(use-package company
  :diminish company-mode
  :hook ((after-init-hook . global-company-mode))
  :config
  (add-to-list 'company-backends 'company-flow)
  (add-to-list 'company-backends 'company-dabbrev)
  (add-to-list 'company-backends 'company-dabbrev-code)
  (add-to-list 'company-backends 'company-etags)
  (setq company-tooltip-align-annotations t))
(use-package company-flow)
(use-package counsel
  :delight
  :bind*
  (("M-x" . counsel-M-x)
   ("C-s" . swiper)
   ("C-x C-f" . counsel-find-file)
   ("C-c d d" . counsel-descbinds)
   ("C-c s s" . counsel-ag))
  :config
  (progn
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (counsel-mode)
    (ivy-mode 1)))
(with-eval-after-load 'counsel
  (when (eq system-type 'windows-nt)
    (defun counsel-locate-cmd-es (input)
      "Return a shell command based on INPUT."
      (counsel-require-program "es.exe")
      (format "es.exe -r %s"
              (counsel--elisp-to-pcre
               (ivy--regex input t))))))
(use-package dired)
(use-package dired-efap)
;; (use-package eslintd-fix
;;   :hook ((web-mode . eslintd-fix-mode)
;;          (rjsx-mode . eslintd-fix-mode)))
(use-package expand-region)
(use-package flycheck
  :hook ((web-mode . flycheck-mode)
         (rjsx-mode . flycheck-mode)
         (js2-mode . flycheck-mode))
  :config (progn
            (flycheck-add-mode 'javascript-eslint 'web-mode)
            (advice-add 'flycheck-eslint-config-exists-p :override (lambda() t))
            ))
(use-package git-timemachine)
(use-package highline
  :delight global-highline-mode)
(use-package ido)
(use-package ido-completing-read+)
(use-package itail)
(use-package isearch-symbol-at-point)
(use-package markdown-mode)
(use-package magit
  :bind ("M-j g" . magit-status))
(use-package move-dup)
(use-package org)
(use-package ox)
(use-package ox-reveal)
(use-package prettier-js
  :hook
  (web-mode . (lambda ()
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (prettier-js-mode)))))
(use-package powerline)
(use-package projectile
  :diminish projectile-mode
  :init
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  :config
  (setq projectile-indexing-method 'alien)
  (setq projectile-enable-caching 't)
  (projectile-global-mode))
(use-package rjsx-mode)
(use-package sass-mode)
(use-package simp)
(use-package slime)
(use-package solarized-theme
  :init
  (load-theme 'solarized-light t t)
  (enable-theme 'solarized-light))
(use-package smart-indent-rigidly)
(use-package smex)
(use-package tide
  :preface
  (defun setup-tide-mode ()
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))
  :hook
  (typescript-mode . setup-tide-mode)
  (web-mode . (lambda ()
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (setup-tide-mode)))))
(use-package typescript-mode
  :mode
  ("\\.ts\\'" . typescript-mode))
(use-package visible-mark)
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.erb\\'" . web-mode)
  ("\\.mustache\\'" . web-mode)
  ("\\.tsx\\'" . web-mode)
  ("\\.jsp\\'" . web-mode)
  ("\\.js?\\'" . web-mode)
  :config
  ;; (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; (flycheck-add-mode 'typescript-tslint 'web-mode)
  (setq web-mode-tag-auto-close-style t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-indentation t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-quoting t)
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js[x]?\\'"))))
(use-package yaml-mode)

;; (use-package my-theme)
;; (use-package my-isearch)
;; (use-package my-backup)
;; (use-package my-autoloads)
;; (use-package my-add-to-lists)
(use-package my-project-definitions)
(use-package my-hooks)
(setq-default kill-read-only-ok t
              indent-tabs-mode nil)
;; (use-package my-settings)


(go-to-hell-bars)

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist '((".*" . "~/.emacs.d/.backups"))    ; don't litter my fs tree
 auto-save-file-name-transforms '((".*" "~/.emacs.d/.backups" t))
 tramp-backup-directory-alist backup-directory-alist
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

                                        ; invalidate projectile cache when switching branches in magit
(defun run-projectile-invalidate-cache (&rest _args)
  ;; We ignore the args to `magit-checkout'.
  (projectile-invalidate-cache nil))
(advice-add 'magit-checkout
            :after #'run-projectile-invalidate-cache)
(advice-add 'magit-branch-and-checkout ; This is `b c'.
            :after #'run-projectile-invalidate-cache)
(put 'downcase-region 'disabled nil)

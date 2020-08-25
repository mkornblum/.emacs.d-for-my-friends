(let ((default-directory  "~/.emacs.d/"))
  (setq load-path
        (append
         (let ((load-path  (copy-sequence load-path))) ;; Shadow
           (append 
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; from https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-completion-provider :capf)

(use-package org)
(use-package company
  :diminish company-mode
  :hook ((after-init-hook . global-company-mode))
  (setq company-tooltip-align-annotations t))

(require 'my-functions)
(require 'my-keybindings)
(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file)

(use-package delight)

(use-package add-node-modules-path
  :hook ((web-mode . add-node-modules-path)
	 (typescript-mode . add-node-modules-path)))
(use-package auto-complete)
(use-package avy)
(use-package auto-indent-mode)
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
    (setq ivy-re-builders-alist
	  '((swiper . ivy--regex-plus)
	    (t      . ivy--regex-fuzzy)))
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (counsel-mode)
    (ivy-mode 1)))
(use-package dap-mode)
(use-package eslintd-fix
  :hook ((web-mode . eslintd-fix-mode)))
(use-package exec-path-from-shell)
(use-package expand-region)
(use-package flycheck
  :hook ((web-mode . flycheck-mode)))
(use-package git-timemachine)
(use-package ido)
(use-package ido-completing-read+)
(use-package itail)
(use-package isearch-symbol-at-point)
(use-package lua-mode)
(use-package lsp-mode
  :init (setq lsp-inhibit-message t
              lsp-eldoc-render-all nil
              lsp-highlight-symbol-at-point nil)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (java-mode . lsp))
  :commands lsp)
(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-symbol t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-update-mode 'point))
(use-package markdown-mode)
(use-package magit
  :bind ("M-j g" . magit-status))
(use-package move-dup)
(use-package multiple-cursors)
(use-package ox-reveal)
(use-package prettier-js
  :hook
  (web-mode . (lambda ()
		(when (string-equal "tsx" (file-name-extension buffer-file-name))
		  (prettier-js-mode)))))
(use-package powerline)
(use-package solarized-theme
  :init 
  (load-theme 'solarized-light t))
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
  ("\\.js?\\'" . web-mode)
  :config
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (setq web-mode-tag-auto-close-style t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-indentation t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-quoting t)
  (setq web-mode-content-types-alist
	'(("jsx" . "\\.js[x]?\\'"))))

;; (use-package my-theme)
;; (use-package my-isearch)
;; (use-package my-backup)
;; (use-package my-autoloads)
;; (use-package my-add-to-lists)
;; (use-package my-project-definitions)
;; (use-package my-hooks)
;; (use-package my-settings)

(go-to-hell-bars)
(exec-path-from-shell-initialize)

(setq
 default-directory "~/"
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist '((".*" . "~/.emacs.d/.backups"))    ; don't litter my fs tree
 auto-save-file-name-transforms '((".*" "~/.emacs.d/.backups" t))
 tramp-backup-directory-alist backup-directory-alist
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))
(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package my-functions)
(use-package my-keybindings)
(use-package delight
  :ensure t
  :pin gnu)

(use-package add-node-modules-path
  :hook ((web-mode . add-node-modules-path)
	 (rjsx-mode . add-node-modules-path)
	 (js2-mode . add-node-modules-path)))
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
  (add-to-list 'company-backends 'company-etags))
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
    (setq ivy-re-builders-alist
	  '((swiper . ivy--regex-plus)
	    (t      . ivy--regex-fuzzy)))
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (counsel-mode)
    (ivy-mode 1)))
(use-package dired)
(use-package dired-efap)
(use-package elm-mode)
(use-package emojify
  :config
  (global-emojify-mode))
(use-package eslintd-fix
  :hook ((web-mode . eslintd-fix-mode)
	 (rjsx-mode . eslintd-fix-mode)))
(use-package exec-path-from-shell)
(use-package expand-region)
(use-package flycheck
  :hook ((web-mode . flycheck-mode)
	 (rjsx-mode . flycheck-mode)
	 (js2-mode . flycheck-mode)))
(use-package flycheck-flow
  :config
  (progn
    (flycheck-add-mode 'javascript-flow 'web-mode)
    (flycheck-add-mode 'javascript-flow 'rjsx-mode)
    (flycheck-add-next-checker 'javascript-flow 'javascript-eslint)))

(use-package git-timemachine)
(use-package highline
  :delight global-highline-mode)
(use-package ido)
(use-package ido-completing-read+)
(use-package itail)
(use-package isearch-symbol-at-point)
(use-package flow-minor-mode
  :hook ((web-mode . flow-minor-enable-automatically)))
(use-package lua-mode)
(use-package markdown-mode)
(use-package magit
  :bind ("M-j g" . magit-status))
(use-package move-dup)
(use-package multiple-cursors)
(use-package powerline)
(use-package rjsx-mode)
(use-package sass-mode)
(use-package simp)
(use-package slime)
(use-package solarized-theme
  :init 
  (load-theme 'solarized-dark t t)
  (enable-theme 'solarized-dark))
(use-package smart-indent-rigidly)
(use-package smex)
(use-package tide)
(use-package visible-mark)
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.erb\\'" . web-mode)
  ("\\.mustache\\'" . web-mode)
  ("\\.js?\\'" . web-mode)
  :config
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
(use-package my-project-definitions)
;; (use-package my-hooks)
;; (use-package my-settings)

(go-to-hell-bars)
(exec-path-from-shell-initialize)

(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist '((".*" . "~/.emacs.d/.backups"))    ; don't litter my fs tree
 auto-save-file-name-transforms '((".*" "~/.emacs.d/.backups" t))
 tramp-backup-directory-alist backup-directory-alist
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

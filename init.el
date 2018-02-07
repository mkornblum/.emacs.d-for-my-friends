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

(use-package add-node-modules-path
  :ensure t)
(use-package auto-complete
  :ensure t)
(use-package auto-indent-mode
  :ensure t)
(use-package company
  :ensure t)
(use-package counsel
  :ensure t
  :bind*
  (("M-x" . counsel-M-x)
   ("C-s" . swiper)
   ("C-x C-f" . counsel-find-file)
   ("C-c d d" . counsel-descbinds)
   ("C-c s s" . counsel-ag))
  :config
  (setq ivy-re-builders-alist
	'((swiper . ivy--regex-plus)
	  (t      . ivy--regex-fuzzy)))
  (setq ivy-use-virtual-buffers t)
  (setq ivy-extra-directories nil)
  (setq ivy-count-format "(%d/%d) ")
  (counsel-mode)
  (ivy-mode 1))
(use-package dired
  :ensure t)
(use-package dired-efap
  :ensure t)
(use-package elm-mode
  :ensure t)
(use-package emojify
  :ensure t
  :config
  (global-emojify-mode))
(use-package exec-path-from-shell
  :ensure t)
(use-package expand-region
  :ensure t)
(use-package flycheck
  :ensure t)
(use-package flycheck-flow
  :ensure t)
(use-package highline
  :ensure t)
(use-package ido
  :ensure t)
(use-package ido-completing-read+
  :ensure t)
(use-package itail
  :ensure t)
(use-package isearch-symbol-at-point
  :ensure t)
(use-package lua-mode
  :ensure t)
(use-package markdown-mode
  :ensure t)
(use-package magit
  :ensure t)
(use-package movepp-dup
  :ensure t)
(use-package multiple-cursors
  :ensure t)
(use-package powerline
  :ensure t)
(use-package prettier-js
  :ensure t)
(use-package rjsx-mode
  :ensure t)
(use-package sass-mode
  :ensure t)
(use-package simp
  :ensure t)
(use-package slime
  :ensure t)
(use-package solarized-theme
  :ensure t
  :init 
  (load-theme 'solarized-dark t t)
  (enable-theme 'solarized-dark))
(use-package smart-indent-rigidly
  :ensure t)
(use-package smex
  :ensure t)
(use-package tide
  :ensure t)
(use-package visible-mark
  :ensure t)
(use-package web-mode
  :ensure t)

;; (use-package my-theme)
;; (use-package my-isearch)
(use-package my-backup)
;; (use-package my-autoloads)
;; (use-package my-add-to-lists)
;; (use-package my-project-definitions)
(use-package my-functions)
;; (use-package my-initializers)
(use-package my-keybindings)
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

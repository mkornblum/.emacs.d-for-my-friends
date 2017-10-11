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

(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(use-package add-node-modules-path
  :ensure t)
(use-package auto-indent-mode
  :ensure t)
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
(use-package magit
  :ensure t)
(use-package move-dup
  :ensure t)
(use-package multiple-cursors
  :ensure t)
(use-package powerline
  :ensure t)
(use-package rjsx-mode
  :ensure t)
(use-package simp
  :ensure t)
(use-package slime
  :ensure t)
(use-package solarized-theme
  :ensure t)
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

(use-package my-theme)
(use-package my-isearch)
(use-package my-backup)
(use-package my-autoloads)
(use-package my-add-to-lists)
(use-package my-project-definitions)
(use-package my-functions)
(use-package my-initializers)
(use-package my-keybindings)
(use-package my-hooks)
(use-package my-settings)

(smex-initialize)
(icomplete-mode)
(ido-mode t)
(ido-ubiquitous-mode t)
(winner-mode)
(go-to-hell-bars)
(recentf-mode t)
(show-paren-mode t)
(highline-mode 1)
(auto-compression-mode 1)
(powerline-default-theme)
(setq magit-last-seen-setup-instructions "1.4.0")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(provide 'my-initializers)

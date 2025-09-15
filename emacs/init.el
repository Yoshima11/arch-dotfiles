(message "Cargando configuración desde ~/.config/emacs/init.el")
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(unless (package-installed-p 'use-package)
  (unless package-refrexh-content
    (package-refresh-contents))
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
(global-linum-mode t)
(global-font-lock-mode t)
(use-package company
  :ensure t
  :config
  (global-company-mode t))
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))
(use-package pyvenv
  :ensure t)
(add-hook 'python-mode-hook 'pyvenv-mode)

(menu-bar-mode 1)
(scroll-bar-mode 1)
(tool-bar-mode -1)

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi-tinted :no-confirm-loading))

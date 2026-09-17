;;; package --- Summary -*- lexical-binding: t; -*-
;;; Commentary:
;;; My Emacs config
;;; Code:
(load (expand-file-name "elpaca-init.el" user-emacs-directory))

(use-package compat    :ensure t)
(use-package transient :ensure t)

;; Performance
(setq gc-cons-threshold (* 50 1000 1000))
(setq load-prefer-newer t)

(use-package flymake
  :ensure nil)

;; UI settings
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq inhibit-startup-screen t
      ring-bell-function 'ignore)

;; Font settings
(set-face-attribute 'default nil :font "Fantasque Sans Mono-14")
(setq-default line-spacing 0.12)

;; Editor behavior
(delete-selection-mode t)
(electric-pair-mode t)
(global-auto-revert-mode t)
(global-display-line-numbers-mode t)

(setq auto-save-default nil
      make-backup-files nil)
(setq scroll-conservatively 10
      mouse-wheel-progressive-speed nil)

;; Backup settings
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying-when-linked t
      backup-by-copying t)

;; Key bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-+")      'text-scale-increase)
(global-set-key (kbd "C--")      'text-scale-decrease)

;; Package configurations
(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-.") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C->") 'mc/mark-all-like-this)
  )

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(use-package vterm :ensure t)

(use-package projectile
  :ensure t)

(use-package astyle
  :ensure t
  :when (executable-find "astyle"))

(use-package eglot
  :ensure nil
  :hook
  (c-mode . eglot-ensure)
  (c-ts-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (c++-ts-mode . eglot-ensure)

  (go-ts-mode . eglot-ensure)
  (go-mod-ts-mode . eglot-ensure)
  
  (java-mode . eglot-ensure)
  (js-ts-mode . eglot-ensure)
  (tsx-ts-mode . eglot-ensure)
  (typescript-mode . eglot-ensure)
  (cmake-ts-mode . eglot-ensure)
  (python-mode . eglot-ensure)
  (python-ts-mode . eglot-ensure)

  :bind
  ("C-c l f" . eglot-format)
  
  :config
  (setq eglot-events-buffer-size 0
        eglot-autoshutdown t
        eglot-report-progress nil)
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
  )

(use-package treesit-auto
  :ensure t
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package yasnippet-snippets
  :ensure t
  :config
  (yas-minor-mode 1))
(use-package which-key :ensure nil :hook (prog-mode . which-key-mode))

(use-package magit
  :ensure t
  :bind
  ("C-x g" . magit-status))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-popupinfo-mode t)
  (corfu-popupinfo-delay 0.5)
  (corfu-separator ?\s)
  (completion-ignore-case t)
  (tab-always-indent 'complete)
  (corfu-preview-current nil)
  :init (global-corfu-mode))

(use-package cape
  :ensure t
  :after corfu
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-elisp-symbol))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles              '(orderless basic)
        completion-category-overrides  '((file (styles partial-completion)))
        completion-category-defaults    nil
        completion-pcm-leading-wildcard t))

(use-package vertico
  :ensure t
  :custom (vertico-cycle t)
  :init (vertico-mode 1))

(use-package marginalia
  :ensure t
  :init (marginalia-mode 1))

(use-package consult
  :ensure t
  :bind
  (("C-x b"   . consult-buffer)
   ("M-y"     . consult-yank-pop)
   ("M-g g"   . consult-goto-line)
   ("M-g M-g" . consult-goto-line)
   ("M-g i"   . consult-imenu)
   ("M-s l"   . consult-line)
   ("M-s r"   . consult-ripgrep)
   ("M-s g"   . consult-grep)
   ("M-s d"   . consult-find)
   ("M-s k"   . consult-keep-lines))
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function       #'consult-xref
        xref-show-definitions-function #'consult-xref))

;; --- ai stuff ---
(use-package agent-shell
  :ensure t)
;; --- ai stuff ---

(provide 'init)
;;; init.el ends here

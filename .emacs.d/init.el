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

;; Evil mode 
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-respect-visual-line-mode t
        evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)) 

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode 1))

(use-package general
  :ensure t
  :after evil
  :config
  (general-evil-setup)
  (general-create-definer
    leader
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")
  (setq dired-kill-when-opening-new-dired-buffer t)
  (leader
    "-"   '(dired-jump :which-key "open dired")
    "SPC" '(find-file  :which-key "find file")))

(use-package flymake
  :ensure nil
  :after general
  :config
  (general-def 'motion 'flymake-mode-map
    "] d" 'flymake-goto-next-error
    "[ d" 'flymake-goto-prev-error))

;; UI settings
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq inhibit-startup-screen t
      ring-bell-function 'ignore)

;; Font settings
(set-face-attribute 'default nil :font "FantasqueSansM Nerd Font-14")
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
  (leader
   "m"   '(:ignore t                  :which-key "[m]ark ...")
   "m n" '(mc/mark-next-like-this     :which-key "[n]ext like this")
   "m p" '(mc/mark-previous-like-this :which-key "[p]revious like this")
   "m a" '(mc/mark-all-like-this      :which-key "[a]ll like this")))

(use-package gruber-darker-theme
  :ensure t
  :config (load-theme 'gruber-darker t))

(use-package vterm :ensure t)

(use-package projectile
  :ensure t
  :config
  (leader
   "p" '(:keymap projectile-command-map :which-key "[p]rojectile")))

(use-package eglot
  :ensure nil
  :hook
  (c-mode . eglot-ensure)
  (c-ts-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  (c++-ts-mode . eglot-ensure)
  (java-mode . eglot-ensure)
  (js-ts-mode . eglot-ensure)
  (tsx-ts-mode . eglot-ensure)
  (typescript-mode . eglot-ensure)
  (cmake-ts-mode . eglot-ensure)
  :config
  (setq eglot-events-buffer-size 0
        eglot-autoshutdown t
        eglot-report-progress nil)
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
  (leader
    :states '(normal visual)
    :keymaps 'eglot-mode-map
    "l f" '(eglot-format :which-key "eglot-format file")))

(use-package treesit-auto
  :ensure t
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package yasnippet-snippets :ensure t)
(use-package which-key :ensure nil :hook (prog-mode . which-key-mode))

(use-package magit
  :ensure t
  :config
  (leader
   "g" '(:ignore t      :which-key "[g]it")
   "g g" '(magit-status  :which-key "[g]it status")))

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
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function       #'consult-xref
        xref-show-definitions-function #'consult-xref)
  (leader
    "/" '(consult-line                  :which-key "find ...")
    "c"   '(:ignore t                   :which-key "[c]onsult ...")
    "c y" '(consult-yank-from-kill-ring :which-key "[y]ank")
    "c i" '(consult-imenu               :which-key "[i]menu")
    "c g" '(consult-ripgrep             :which-key "rip[g]rep")
    "c m" '(consult-man                 :which-key "[m]an page")
    "c f" '(consult-file                :which-key "find [f]ile") 
  ))

;; Lisp modes
(use-package paredit
  :ensure t
  :hook
  (enable-paredit-mode . emacs-lisp-mode)
  (enable-paredit-mode . eval-expression-minibuffer-setup)
  (enable-paredit-mode . ielm-mode)
  (enable-paredit-mode . lisp-mode)
  (enable-paredit-mode . lisp-interaction-mode)
  (enable-paredit-mode . scheme-mode))

(setq treesit-language-source-alist
      '((c3 "https://github.com/c3lang/tree-sitter-c3")))

(use-package sly          :ensure t)
(use-package geiser-guile :ensure t)
(use-package clojure-mode :ensure t)
(use-package cider        :ensure t)
(use-package c3-ts-mode
  :ensure (:host github :repo "c3lang/c3-ts-mode")
  :mode ("\\.c3\\'" . c3-ts-mode))

(provide 'init)
;;; init.el ends here

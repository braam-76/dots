;;; package --- Summary -*- coding: utf-8; lexical-binding: t -*-
;;; Commentary:
;; braam's Emacs config
;;; Code:

;;; Load lisp/*.el files
(add-to-list 'load-path (concat user-emacs-directory "lisp/"))

;; (setenv "PATH" (concat "/usr/bin:" (getenv "PATH")))
;; (add-to-list 'exec-path "/usr/bin")

;; Set up elpaca (see lisp/package-manager.el)
(require 'package-manager)

;;; Built-in tweaks
(setq make-backup-files nil) ;; Stop creating ~ backup files
(setq auto-save-default nil) ;; Stop creating # auto save files
(setq delete-by-moving-to-trash t)

(setq tab-always-indent 'complete)
(setq text-mode-ispell-word-completion nil)

(setq native-comp-async-report-warnings-errors 'silent)
(setq warning-minimum-level :error)

(set-face-attribute 'default     nil :font "Fantasque Sans Mono-14")
(set-face-attribute 'fixed-pitch nil :font "Fantasque Sans Mono-14")

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;; Prevent Emacs from resizing the frame when bars are toggled, reduces flickers on startup
(setq frame-inhibit-implied-resize t)

(delete-selection-mode t)
(electric-indent-mode nil) ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode t)

(global-auto-revert-mode t)
(setq use-short-answers t)

(recentf-mode t)

(pixel-scroll-precision-mode t)
(setq pixel-scroll-precision-use-momentum nil)

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;;; Theme
(use-package zenburn-theme :ensure t
  :config
  (load-theme 'zenburn t))

;;; Magit
;; https://github.com/progfolio/elpaca/issues/283
(use-package transient :ensure t :demand t)
(use-package magit :ensure t)

;;; Better dired
(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-lah --group-directories-first")
  :bind (:map dired-mode-map
              ("<left>"  . dired-up-directory)
              ("<right>" . dired-find-file)))

;;; Read shell's PATH
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;;; Vterm - terminal emulator
(use-package vterm
  :ensure t
  :custom
  (shell-file-name "/bin/bash")
  (vterm-max-scrollback 5000))

;;; Minibuffer completion
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  (vertico-resize nil)
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode))

(use-package orderless
  :after vertico
  :ensure t
  :custom
  (completion-styles '(orderless))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t))

;;; In-buffer completion
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)
  (corfu-popupinfo-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-auto-delay 0.2)
  (corfu-auto-trigger ".")
  (corfu-quit-no-match 'separator))

;; Multilingual keybindings
(use-package reverse-im
  :ensure t
  :config
  (reverse-im-activate "russian-computer"))

(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook  #'flymake-mode)
  (setq eglot-ignored-server-capabilities '(:inlayHintProvider)))

(require 'languages)

(provide 'init)
;;; init.el ends here

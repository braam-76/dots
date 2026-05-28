;;; init.el -*- coding: utf-8; lexical-binding: t; -*-
;;; Commentary:
;; braam's Emacs config
;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "lisp/"))
(require 'package-manager)

;; ---------------------------------------------------------------------------
;; Core Emacs behavior
;; ---------------------------------------------------------------------------

(setq make-backup-files nil
      auto-save-default nil
      delete-by-moving-to-trash t)

(setq tab-always-indent 'complete
      text-mode-ispell-word-completion nil)

(setq-default indent-tabs-mode nil
              tab-width 2)

(delete-selection-mode t)
(electric-indent-mode nil)
(electric-pair-mode t)

(setq native-comp-async-report-warnings-errors 'silent
      warning-minimum-level :error)

(pixel-scroll-precision-mode t)
(setq pixel-scroll-precision-use-momentum nil)

(recentf-mode t)
(savehist-mode t)
(global-auto-revert-mode t)

(setq use-short-answers t
      inhibit-startup-screen t
      frame-inhibit-implied-resize t)

;; ---------------------------------------------------------------------------
;; UI / appearance
;; ---------------------------------------------------------------------------

(set-face-attribute 'default nil :font "Fantasque Sans Mono-14")
(set-face-attribute 'fixed-pitch nil :font "Fantasque Sans Mono-14")

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(dolist (mode '(term-mode-hook vterm-mode-hook shell-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'vague t)
(use-package zenburn-theme
  :init
  (load-theme 'zenburn t))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(use-package which-key
  :init
  (which-key-mode)
  :custom
  (which-key-idle-delay 0.25)
  (which-key-sort-order #'which-key-key-order-alpha))

;; ---------------------------------------------------------------------------
;; Completion stack
;; ---------------------------------------------------------------------------

(use-package vertico
  :init (vertico-mode)
  :custom (vertico-cycle t))

(use-package marginalia
  :init (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil))

(use-package consult :ensure t)

(use-package embark :ensure t)

(use-package embark-consult
  :after (embark consult))

;; ---------------------------------------------------------------------------
;; In-buffer completion
;; ---------------------------------------------------------------------------

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; ---------------------------------------------------------------------------
;; Git
;; ---------------------------------------------------------------------------

(use-package transient
  :demand t)

(use-package magit
  :after transient)

;; ---------------------------------------------------------------------------
;; File manager
;; ---------------------------------------------------------------------------

(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-lah --group-directories-first")
  :bind
  (:map dired-mode-map
        ("<left>" . dired-up-directory)
        ("<right>" . dired-find-file)))

;; ---------------------------------------------------------------------------
;; Shell / terminal
;; ---------------------------------------------------------------------------

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package vterm
  :custom
  (shell-file-name "/usr/bin/fish"))

;; ---------------------------------------------------------------------------
;; Keyboard remap helper
;; ---------------------------------------------------------------------------

(use-package reverse-im
  :config
  (reverse-im-activate "russian-computer"))

;; ---------------------------------------------------------------------------
;; Evil mode (modal editing)
;; ---------------------------------------------------------------------------

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybindings nil   ; required by evil-collection
        evil-want-C-u-scroll t
        evil-want-C-d-scroll t
        evil-want-C-g-bindings t)
  :config
  (evil-mode t)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'help-mode 'normal)
  (evil-set-initial-state 'vterm-mode 'insert))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-setup-minibuffer t)
  (evil-collection-calendar-want-org-bindings t)
  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

(use-package general
  :after evil
  :config
  (general-override-mode)

  (general-create-definer braam/leader
    :states '(normal visual motion emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "SPC")

  ;; Leader key bindings
  (braam/leader
    "-"  '(find-file :which-key "find file")
    "fr" '(recentf-open-files :which-key "recent")

    "b"  '(:ignore t :which-key "buffers")
    "bb" '(consult-buffer :which-key "switch")
    "bk" '(kill-current-buffer :which-key "kill")

    "g"  '(magit-status :which-key "magit")

    "l"  '(:ignore t :which-key "lsp")
    "lf" '(eglot-format :which-key "format"))

  (general-define-key
   :states 'normal
   "g r a" #'eglot-code-actions
   "g r n" #'eglot-rename
   "g r r" #'xref-find-references
   "g r t" #'xref-find-definitions
   "g r x" #'eglot-execute-command
   "g o"   #'eglot-code-action-organize-imports
   "g e"   #'flymake-show-buffer-diagnostics
   "g j"   #'flymake-goto-next-error
   "g k"   #'flymake-goto-prev-error))

;; ---------------------------------------------------------------------------
;; LSP (eglot)
;; ---------------------------------------------------------------------------

(use-package eglot
  :ensure nil
  :hook
  (eglot-managed-mode . flymake-mode)
  ;; (eglot-managed-mode . flycheck-mode)
  :custom
  (eglot-ignored-server-capabilities '(:inlayHintProvider)))

;; ---------------------------------------------------------------------------
;; Treesitter
;; ---------------------------------------------------------------------------

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; ---------------------------------------------------------------------------
;; Extra modules
;; ---------------------------------------------------------------------------

(require 'languages)
(require 'emacs-dev)

(provide 'init)
;;; init.el ends here

;;; init.el --- User Emacs configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; My Emacs config
;;; Code:

;; Keep settings saved by Customize in a separate file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Built-in package manager.
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(require 'use-package)

(use-package compat    :ensure t)
(use-package transient :ensure t)

;; Performance
(setq gc-cons-threshold (* 50 1000 1000))
(setq load-prefer-newer t)

;; Load Omarchy integration (theme syncing, font syncing, file watchers).
(load (expand-file-name "omarchy" user-emacs-directory))

(use-package flymake
  :ensure nil)

;; UI settings
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq inhibit-startup-screen t
      ring-bell-function 'ignore)

;; A compact, theme-aware status bar without requiring icon fonts.
(use-package doom-modeline
  :ensure t
  :demand t
  :custom
  (doom-modeline-height 30)
  (doom-modeline-bar-width 3)
  (doom-modeline-icon nil)
  (doom-modeline-minor-modes nil)
  :custom-face
  (doom-modeline-buffer-file ((t (:foreground "black"))))
  (doom-modeline-buffer-path ((t (:foreground "black"))))
  (doom-modeline-buffer-modified ((t (:foreground "black"))))
  :config
  (doom-modeline-mode 1))

;; Hide only link count, owner and group; `(' still reveals all details.
(use-package dired
  :ensure nil
  :custom
  (dired-hide-details-preserved-columns '(1 5 6 7 8))
  (dired-hide-details-hide-information-lines nil)
  (dired-hide-details-hide-symlink-targets nil)
  :hook
  (dired-mode . dired-hide-details-mode)
  (dired-mode . hl-line-mode)
  (dired-mode . (lambda () (display-line-numbers-mode -1))))

(use-package diredfl
  :ensure t
  :hook (dired-mode . diredfl-mode)
  :config
  (dolist (face '(diredfl-dir-priv diredfl-exec-priv diredfl-other-priv
                  diredfl-write-priv diredfl-read-priv diredfl-no-priv
                  diredfl-rare-priv diredfl-link-priv))
    (set face 'default)))

;; Overlays keep Git status separate from Dired's filenames and editable text.
(defun my-dired-git-status ()
  "Show Git's index/worktree status before filenames in local Dired buffers."
  (remove-overlays (point-min) (point-max) 'my-dired-git-status t)
  (unless (file-remote-p default-directory)
    (require 'vc-git)
    (when-let* ((root (vc-git-root default-directory)))
      (let ((directory default-directory)
            (statuses (make-hash-table :test #'equal)))
        (when (with-temp-buffer
                (let ((default-directory root))
                  ;; shortcut: synchronous Git query; use async if large repos make refresh slow.
                  (when (eq 0 (process-file "git" nil t nil "status"
                                           "--porcelain=v1" "-z"
                                           "--untracked-files=normal"
                                           "--" directory))
                    (let ((records (split-string (buffer-string) "\0" t)))
                      (while records
                        (let* ((record (pop records))
                               (status (substring record 0 2))
                               (file (directory-file-name
                                      (expand-file-name (substring record 3) root))))
                          (puthash file status statuses)
                          ;; In -z output, renames/copies include a second, source path.
                          (when (string-match-p "[RC]" status)
                            (pop records)))))
                    t)))
          (save-excursion
            (goto-char (point-min))
            (while (not (eobp))
              (when-let* ((file (dired-get-filename nil t)))
                (dired-move-to-filename)
                (let ((overlay (make-overlay (point) (point)))
                      (status (gethash (directory-file-name file) statuses "  ")))
                  (overlay-put overlay 'my-dired-git-status t)
                  (overlay-put overlay 'before-string (concat status " "))))
              (forward-line 1))))))))

(add-hook 'dired-after-readin-hook #'my-dired-git-status)

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
;; Translate GUI Escape to C-g, including in minibuffers and local keymaps.
(define-key input-decode-map (kbd "<escape>") (kbd "C-g"))
(global-set-key (kbd "C-+")      'text-scale-increase)
(global-set-key (kbd "C--")      'text-scale-decrease)

;; Package configurations
(use-package reverse-im
  :ensure t
  :demand t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode 1))

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-.") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C->") 'mc/mark-all-like-this))

(use-package vterm :ensure t)

(use-package projectile
  :ensure t)

(use-package astyle
  :ensure t
  :when (executable-find "astyle"))

(use-package eglot
  :ensure nil
  :hook
  (c-mode	   . eglot-ensure)
  (c-ts-mode	   . eglot-ensure)
  (c++-mode	   . eglot-ensure)
  (c++-ts-mode	   . eglot-ensure)
  (go-ts-mode	   . eglot-ensure)
  (go-mod-ts-mode  . eglot-ensure)
  (java-mode	   . eglot-ensure)
  (js-ts-mode	   . eglot-ensure)
  (tsx-ts-mode	   . eglot-ensure)
  (typescript-mode . eglot-ensure)
  (cmake-ts-mode   . eglot-ensure)
  (python-mode	   . eglot-ensure)
  (python-ts-mode  . eglot-ensure)
  :bind
  ("C-c l f" . eglot-format)
  :config
  (setq eglot-events-buffer-size 0
        eglot-autoshutdown t
        eglot-report-progress nil)
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider))

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
  :ensure t
  :custom
  (agent-shell-preferred-agent-config 'opencode)
  (agent-shell-opencode-acp-command
   (list (expand-file-name "~/.local/share/mise/shims/opencode") "acp")))
;; --- ai stuff ---

(load custom-file 'noerror)

(provide 'init)
;;; init.el ends here

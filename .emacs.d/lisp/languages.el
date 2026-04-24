;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Code:

;; C, C++
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'c-or-c++-mode-hook #'eglot-ensure)
(add-hook 'cmake-mode-hook #'eglot-ensure)

;; Python
(add-hook 'python-mode-hook    #'eglot-ensure)
(add-hook 'python-ts-mode-hook #'eglot-ensure)
;; Ruff for linting (separate from eglot/basedpyright)
(use-package flymake-ruff
  :ensure t
  :hook
  (python-mode-hook    . flymake-ruff-load)
  (python-ts-mode-hook . flymake-ruff-load))

;; Common Lisp
(use-package sly :ensure t)

;; Doom-like code bindings for Eglot
(with-eval-after-load 'eglot
  (keymap-global-set "C-c c a" #'eglot-code-actions)
  (keymap-global-set "C-c c r" #'eglot-rename)
  (keymap-global-set "C-c c x" #'eglot-execute-command)
  (keymap-global-set "C-c c f" #'eglot-format)
  (keymap-global-set "C-c c o" #'eglot-code-action-organize-imports)
  (keymap-global-set "C-c c h" #'eldoc)
  (keymap-global-set "C-c c d" #'xref-find-definitions)
  (keymap-global-set "C-c c D" #'xref-find-references)

  (keymap-global-set "C-c c e" #'flymake-show-buffer-diagnostics)
  (keymap-global-set "C-c c n" #'flymake-goto-next-error)
  (keymap-global-set "C-c c p" #'flymake-goto-prev-error))

(provide 'languages)
;;; languages.el ends here

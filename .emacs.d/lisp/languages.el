;;; -*- coding: utf-8; lexical-binding: t -*-
;;; Code:

(use-package rust-mode
  :hook (rust-mode . (lambda ()
                       (setq indent-tabs-mode nil)  ; use spaces
                       (prettify-symbols-mode)))
  :config
  (setq rust-format-on-save t))  ; auto-format with rustfmt

(use-package flymake-ruff
  :hook
  (python-mode . flymake-ruff-load)
  (python-ts-mode . flymake-ruff-load))

;; Lisp ecosystems
(use-package sly :ensure t)
(use-package racket-mode :ensure t)
(use-package geiser-chicken :ensure t)

(use-package typst-ts-mode
  :ensure (:type git :host codeberg :repo "meow_king/typst-ts-mode" :branch "main")
  :custom
  ;; don't add "--open" if you'd like `watch` to be an error detector
  (typst-ts-mode-watch-options "--open")
  
  ;; experimental settings (I'm the main dev, so I enable these)
  (typst-ts-mode-enable-raw-blocks-highlight t)
  (typst-ts-mode-highlight-raw-blocks-at-startup t))

(use-package eglot
  :ensure nil
  :hook
  ;; C / C++
  (c-mode-hook        . eglot-ensure)
  (c++-mode-hook      . eglot-ensure)
  (c-or-c++-mode-hook . eglot-ensure)
  (cmake-mode-hook    . eglot-ensure)
  
  ;; Python
  (python-mode-hook    . eglot-ensure)
  (python-ts-mode-hook . eglot-ensure)

  ;; Rust
  (rust-mode    . eglot-ensure)
  (rust-ts-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer"))))


(provide 'languages)
;;; languages.el ends here

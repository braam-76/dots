;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; ZedMono Nerd Font
(setq font-name "IosevkaTerm Nerd Font")

(setq doom-font (font-spec :family font-name :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family font-name :size 18))

(setq doom-theme 'doom-horizon)

(setq display-line-numbers-type nil)

(setq org-directory "~/org/")

(setq tab-width 2)

(after! treesit
  (setq treesit-language-source-alist
        '((c "https://github.com/tree-sitter/tree-sitter-c")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
          (typescript "https://github.com/tree-sitter/tree-sitter-typescript")
          (rust "https://github.com/tree-sitter/tree-sitter-rust")
          (go "https://github.com/tree-sitter/tree-sitter-go")
          (c3 "https://github.com/c3lang/tree-sitter-c3"))))

(after! eglot
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode rustic-mode) . ("rustup" "run" "stable" "rust-analyzer")))
  (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
  (advice-add 'jsonrpc--log-event :override #'ignore))

(after! c3-ts-mode
  (setq treesit-font-lock-level 4))

;; Set ZSH as default
(setq shell-file-name (executable-find "zsh"))
(setq explicit-shell-file-name shell-file-name)
(after! vterm
  (setq vterm-shell (executable-find "zsh")))
(setenv "SHELL" (executable-find "zsh"))

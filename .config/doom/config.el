;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "ZedMono Nerd Font" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "ZedMono Nerd Font" :size 18))

(setq doom-theme 'doom-horizon)

(setq display-line-numbers-type nil)

(setq org-directory "~/org/")

(setq tab-width 2)

(after! treesit
  (setq treesit-language-source-alist
        '((c "https://github.com/tree-sitter/tree-sitter-c")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
          (rust "https://github.com/tree-sitter/tree-sitter-rust")
          (go "https://github.com/tree-sitter/tree-sitter-go"))))

(after! eglot
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode rustic-mode) . ("rustup" "run" "stable" "rust-analyzer")))
  (setq eglot-ignored-server-capabilities '(:inlayHintProvider)))

;; Set ZSH as default
(setq shell-file-name (executable-find "zsh"))
(setq explicit-shell-file-name shell-file-name)
(after! vterm
  (setq vterm-shell (executable-find "zsh")))
(setenv "SHELL" (executable-find "zsh"))

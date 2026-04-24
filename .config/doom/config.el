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
  (setq treesit-extra-load-path
        (list (expand-file-name "tree-sitter" doom-data-dir)))
  (add-to-list 'treesit-language-source-alist
               '(c . ("https://github.com/tree-sitter/tree-sitter-c" "v0.20.8")))
  (add-to-list 'treesit-language-source-alist
               '(cpp . ("https://github.com/tree-sitter/tree-sitter-cpp" "v0.20.3"))))


(add-to-list 'exec-path (expand-file-name "~/.dotnet/tools"))

(after! eglot
  (add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.cc\\'"  . c++-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.h\\'"   . c++-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.c\\'"   . c-ts-mode))

  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode rustic-mode) . ("rustup" "run" "stable" "rust-analyzer")))
  (add-to-list 'eglot-server-programs '((cmake-mode) . ("/home/braam/.cargo/bin/neocmakelsp" "stdio")))
  (add-to-list 'eglot-server-programs '((csharp-mode) . ("/home/braam/.omnisharp/OmniSharp" "--languageserver")))
  (setq lsp-csharp-omnisharp-roslyn-binary-path "~/.omnisharp/OmniSharp")

  (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
  (advice-add 'jsonrpc--log-event :override #'ignore))

(setq inferior-lisp-program "/usr/local/bin/sbcl"
      sly-net-interface "127.0.0.1"
      sly-host "127.0.0.1")

;; Set BASH as default
(setq shell-file-name (executable-find "bash"))
(setq explicit-shell-file-name shell-file-name)
(after! vterm
  (setq vterm-shell (executable-find "bash")))
(setenv "SHELL" (executable-find "bash"))

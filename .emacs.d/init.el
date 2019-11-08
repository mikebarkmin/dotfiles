;;; init --- custom emacs config

;;; Commentary:
;;; Simple Emacs setup

;;; Code:
(setq user-full-name "Mike Barkmin")
(setq user-mail-address "mike@barkmin.eu")

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(global-hl-line-mode +1)
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Ask "y" or "n" instead of "yes" or "no".
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; reload edited file automaticly
(global-auto-revert-mode t)

;; kill current buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; No Backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Start daemon
(require 'server)
(if (not (server-running-p)) (server-start))

;; Add package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

(setq evil-want-keybinding nil)

(use-package evil
  :ensure t
  :defer t
  :init (evil-mode 1))

(use-package evil-collection
  :requires (evil)
  :ensure t
  :init (evil-collection-init))

(use-package evil-magit
  :requires (evil magit)
  :defer t)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(use-package company
	     :ensure t
	     :defer t
	     :init (global-company-mode))

(use-package elisp-format
  :ensure t)

(use-package autopair
  :ensure t
  :defer t
  :init (autopair-global-mode))

(use-package magit
  :ensure t
  :bind ("C-c m s" . magit-status))

(use-package flycheck
  :ensure t
  :defer t
  :init (global-flycheck-mode))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind
  (("C-c p f" . helm-projectile-find-file)
   ("C-c p p" . helm-projectile-switch-project)
   ("C-c p s" . projectile-save-project-buffers))
  :config
  (projectile-mode +1))

(use-package beacon
  :ensure t
  :config (beacon-mode t))

;; Latex
(use-package auctex
  :ensure t
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
	TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))
	TeX-source-correlate-mode t
	TeX-source-correlate-start-server t)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(use-package reftex
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t))

(use-package helm-bibtex
  :ensure t
  :requires (helm)
  :bind ("C-c b" . helm-bibtex)
  :config
  (setq bibtex-completion-bibliography "~/Sciebo/Zotero.bib"
	bibtex-completion-format-citation-functions
	'((latex-mode . bibtex-completion-format-citation-cite)
	  (org-mode . bibtex-completion-format-citation-org-apa-link-to-PDF)
	  (markdown-mode . bibtex-completion-format-citation-pandoc-citeproc)
	  (default . bibtex-completion-format-citation-default))
	bibtex-completion-pdf-field "file"
	bibtex-completion-pdf-symbol "⌘"
	bibtex-completion-notes-symbol "✎"))

(use-package company-auctex
  :ensure t
  :defer t
  :after (auctex)
  :hook ((LaTeX-mode . company-auctex-init)))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer))

(use-package powerline
  :ensure t)

(use-package powerline-evil
  :requires (evil powerline)
  :ensure t
  :defer t
  :init
  (powerline-evil-center-color-theme))


(use-package dracula-theme
  :ensure t
  :config (load-theme 'dracula t))

(use-package helm
  :ensure t
  :defer t
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (helm-mode t)
  (helm-autoresize-mode 1)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20))

(use-package helm-projectile
  :ensure t
  :requires (helm projectile)
  :config
  (helm-projectile-on))

(use-package lsp-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'java-mode-hook #'lsp)
  (add-hook 'php-mode-hook #'lsp)
  (add-hook 'clojure-mode-hook #'lsp)
  (add-hook 'clojurescript-mode-hook #'lsp)
  (add-hook 'js-mode-hook #'lsp)
  (add-hook 'web-mode-hook #'lsp)
  (setq lsp-prefer-flymake nil))

(use-package lsp-java
  :requires (lsp-mode)
  :ensure t)

(use-package lsp-haskell
  :requires (lsp-mode)
  :ensure t)

(use-package lsp-python-ms
  :requires (lsp-mode)
  :ensure t)

(use-package company-lsp
  :ensure t
  :defer t
  :config
  (push 'company-lsp company-backends))

(use-package lsp-ui
  :ensure t
  :requires (lsp-mode flycheck)
  :config
  (setq lsp-ui-doc-enable t
	lsp-ui-doc-use-childframe t
	lsp-ui-doc-position 'top
	lsp-ui-sideline-enable nil
	lsp-ui-flycheck-enable t
	lsp-ui-flycheck-list-position 'right
	lsp-ui-flycheck-live-reporting t
	lsp-ui-peek-enable t
	lsp-ui-peek-list-width 60
	lsp-ui-peek-peek-height 25)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package prettier-js
  :ensure t
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'js-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode))

(use-package python-black
  :ensure t
  :demand t
  :after python)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-completion-style (quote emacs))
 '(package-selected-packages
   (quote
    (powerline-evil evil-collection evil elisp-format helm-bibtex helm-projectile projectile python-black prettier-js lsp-python-ms lsp-haskell lsp-java company-lsp lsp-ui lsp-mode use-package powerline pdf-tools magit helm flycheck dracula-theme company-auctex beacon autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

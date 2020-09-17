;;; init.el --- Initialization file for Emacs

;;; Commentary: Emacs Startup File --- initialization for Emacs

;; to handle my username/email in git commits

(setq user-full-name "Hari Palappetty"
      user-mail-address "hpalappe@gmail.com")

;; to handle large files
(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

;; utf-8 conventions
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment 'utf-8)

(setq make-backup-files nil)

;;(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
 ;; backup-by-copying t    ; Don't delink hardlinks
 ;; version-control t      ; Use version numbers on backups
  ;; delete-old-versions t  ; Automatically delete excess backups
 ;; kept-new-versions 20   ; how many of the newest versions to keep
  ;;kept-old-versions 5    ; and how many of the old
  ;;)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(menu-bar-mode -1)
;;(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

(column-number-mode t)
(size-indication-mode t)
(setq inhibit-startup-screen t)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
       "%b"))))

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;;(set-frame-font "Hack 12" nil t)

(require 'yasnippet)
(yas-global-mode 1)
(use-package elpy
  :ensure t
  :init
  (elpy-version)
  (elpy-enable))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config))

(use-package smart-mode-line-powerline-theme
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'powerline)
  (add-hook 'after-init-hook 'sml/setup))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode t)
(setq-default tab-width 4
              indent-tabs-mode nil)

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(add-hook 'before-save-hook 'whitespace-cleanup)
(use-package diminish
  :ensure t)
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))
(use-package expand-region
  :ensure t
  :bind ("M-m" . er/expand-region))

(use-package crux
  :ensure t
  :bind
  ("C-k" . crux-smart-kill-line)
  ("C-c n" . crux-cleanup-buffer-or-region)
  ("C-c f" . crux-recentf-find-file)
  ("C-a" . crux-move-beginning-of-line))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(use-package avy
  :ensure t
  :bind
  ("C-=" . avy-goto-char)
  :config
  (setq avy-background t))


(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package magit
  :bind (("C-M-g" . magit-status)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind
  (("C-c p f" . helm-projectile-find-file)
   ("C-c p p" . helm-projectile-switch-project)
   ("C-c p s" . projectile-save-project-buffers))
  :config
  (projectile-mode +1)
  )

(use-package helm
  :ensure t
  :defer 2
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-inside-p t
    helm-move-to-line-cycle-in-source t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  )

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(require 'server)
(if (not (server-running-p)) (server-start))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "dde8c620311ea241c0b490af8e6f570fdd3b941d7bc209e55cd87884eb733b0e" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "fe94e2e42ccaa9714dd0f83a5aa1efeef819e22c5774115a9984293af609fce7" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(org-agenda-files (quote ("~/Dropbox/org/near.org")))
 '(package-selected-packages
   (quote
    (cider org-projectile-helm yasnippet zzz-to-char elpy helm-projectile helm projectile flycheck company avy which-key crux expand-region smartparens diminish smart-mode-line-powerline-theme doom-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (clojure . t)
   (python . t)
   (C . t)))

(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")
(setq elpy-rpc-virtualenv-path 'global)

(setq org-log-done 'time)

;;; init.el ends here

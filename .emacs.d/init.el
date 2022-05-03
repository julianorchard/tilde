(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Remove Default Startup Message Text
(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
;; Visual Bell
(setq visual-bell t)
(set-face-attribute 'default nil :font "Fira Mono" :height 80)
(load-theme 'wombat)
(global-set-key (kbd "<escape>") 'keyboard-esape-quit)

;; Init Package Services
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
            
(package-initialize)
;;(unless package-archive-contents
;;  (package-refresh-contents))
;;(unless (package-installed-p 'use-package)
;;  (package-install 'use-package))

;; Use Package
(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

(use-package ivy
	     :diminish
	     :bind (("C-s" . swiper)
		    :map ivy-minibuffer-map
		    ("TAB" . ivy-alt-done)
		    ("C-l" . ivy-alt-done)
		    ("C-j" . ivy-next-line)
		    ("C-k" . ivy-previous-line)
		    :map ivy-switch-buffer-map
		    ("C-k" . ivy-previous-line)
		    ("C-l" . ivy-done)
		    ("C-d" . ivy-switch-buffer-kill)
		    :map ivy-reverse-i-search-map
		    ("C-k" . ivy-previous-line)
		    ("C-d" . ivy-reverse-i-search-kill))
	     :config
	     (ivy-mode  1))

(use-package doom-modeline
	     :ensure t
	     :init (doom-modeline-mode 1)
	     :custom ((doom-modeline-height 15)))

(setq package-check-signature nil)
(setq package-archives
 '(
   ("melpa" . "https://melpa.org/packages/")
   
   ;; ("org"       . "http://orgmode.org/elpa/")
   ("gnu"       . "http://elpa.gnu.org/packages/")
   
   ("marmalade" .  "http://marmalade-repo.org/packages/")
   )
 )


(defun packages-require (&rest packs)
  "Install and load a package. If the package is not available
   installs it automaticaly."
  (mapc  (lambda (package)
           (unless (package-installed-p package)
                   (package-install package)
                   ;;#'package-require
                   ))
         packs
         ))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq byte-compile-warnings '(cl-functions))
(package-initialize)
;; smex & custom keys
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c p .") 'projectile-add-known-project)
(global-set-key (kbd "s-b") 'bookmark-set)
(global-set-key (kbd "s-m") 'bookmark-jump)
(global-set-key (kbd "s-?") 'renarename-buffer)
(global-set-key (kbd "s-d") 'duplicate-current-line)
;; avy
(global-set-key (kbd "C-c C-l") 'avy-copy-line)
(global-set-key (kbd "C-c C-r") 'avy-copy-region)
(global-set-key (kbd "C-c c") 'avy-goto-char)
(global-set-key (kbd "C-c l") 'avy-goto-line)

;; prjectile
(global-set-key (kbd "C-c p .") 'projectile-add-known-project)
(global-set-key (kbd "C-=") 'er/expand-region)


  ;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(setq package-selected-packages
      '(highlight-indent-guides ac-php ac-php-core ac-python php-mode omnisharp ein flycheck-pyflakes dart-mode dart-server json-mode rjsx-mode js-react-redux-yasnippets pyimpsort pdf-tools auto-virtualenv elpy flycheck-pycheckers ipython-shell-send jedi py-autopep8 py-yapf pyde pydoc-info pyfmt pylint python-x company-web helm-company company-anaconda company-jedi js2-refactor prettier-js exec-path-from-shell fullscreen-mode py-import-check py-isort pycomplete pydoc pyenv-mode python-django python-mode pyvenv pyvirtualenv flycheck expand-region neotree direx emmet-mode multi-web-mode web-mode multiple-cursors ido-vertical-mode projectile smex dark-krystal-theme flatui-dark-theme phoenix-dark-mono-theme phoenix-dark-pink-theme vscdark-theme zerodark-theme atom-dark-theme lsp-ui company-lsp lsp-mode evil evil-avy evil-visual-mark-mode company rainbow-delimiters paredit))


(package-install-selected-packages)

;;(require 'cl)
(put 'scroll-left 'disabled nil)
(packages-require
 'rainbow-delimiters
 'company
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282c34" "#ff6c6b" "#98be65" "#da8548" "#61afef" "#c678dd" "#1f5582" "#abb2bf"])
 '(auto-save-default nil)
 '(backup-directory-alist '(("" . "~/.emacs-backup/")))
 '(company-lsp-cache-candidates t)
 '(custom-enabled-themes '(atom-dark))
 '(custom-safe-themes
   '("2642a1b7f53b9bb34c7f1e032d2098c852811ec2881eec2dc8cc07be004e45a0" "1068ae7acf99967cc322831589497fee6fb430490147ca12ca7dd3e38d9b552a" "31f8d16d264e14e8e39c4f291e26cdd5516772a41660ef2ad895244c22024bd2" "63af2870d82065ce90d4c34054aa0a0e524824e9865af9f90f3d6987e61d756a" "de9fa4b3614611bed2fe75e105bd0d37542924b977299736f158dd4d7343c666" "8b4d8679804cdca97f35d1b6ba48627e4d733531c64f7324f764036071af6534" "0329c772ed96053a73b9ddddf96c1183e23c267955bbdf78e7933057ce9da04b" default))
 '(delete-by-moving-to-trash t)
 '(eldoc-echo-area-use-multiline-p nil)
 '(exec-path-from-shell-arguments '("-l"))
 '(flycheck-pycheckers-checkers '(pylint pep8 flake8))
 '(flycheck-python-mypy-config "~/.mypy.ini")
 '(flycheck-python-mypy-ini "~/.mypy.ini")
 '(global-eldoc-mode nil)
 '(highlight-indent-guides-method 'bitmap)
 '(js-expr-indent-offset 0)
 '(js-indent-level 2)
 '(linum-format " %4i ")
 '(lsp-dart-sdk-dir "~/dev/flutter/bin/cache/dart-sdk/")
 '(lsp-eldoc-enable-hover nil)
 '(lsp-prefer-flymake nil)
 '(lsp-pyls-plugins-flake8-enabled t)
 '(lsp-pyls-plugins-flake8-exclude '("python3 -m flake8"))
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-include-signature t)
 '(lsp-ui-doc-max-height 20)
 '(lsp-ui-doc-max-width 100)
 '(lsp-ui-doc-use-webkit t)
 '(lsp-ui-doc-winum-ignore t)
 '(menu-bar-mode nil)
 '(neo-autorefresh t)
 '(neo-window-fixed-size nil)
 '(package-selected-packages
   '(dired-sidebar syntactic-close clang-format+ clang-format cl-format abyss-theme acme-theme afternoon-theme ahungry-theme airline-themes alect-themes almost-mono-themes ample-theme ample-zen-theme anti-zenburn-theme arc-dark-theme arjen-grey-theme assemblage-theme atom-one-dark-theme autumn-light-theme avk-emacs-themes ayu-theme badger-theme badwolf-theme base16-theme basic-theme berrys-theme birds-of-paradise-plus-theme blackboard-theme bliss-theme borland-blue-theme boron-theme brutal-theme brutalist-theme bubbleberry-theme busybee-theme calmer-forest-theme caroline-theme challenger-deep-theme cherry-blossom-theme chocolate-theme highlight-indent-guides ac-php ac-php-core ac-python php-mode omnisharp ein flycheck-pyflakes dart-mode dart-server json-mode rjsx-mode js-react-redux-yasnippets pyimpsort pdf-tools auto-virtualenv elpy flycheck-pycheckers ipython-shell-send jedi py-autopep8 py-yapf pyde pydoc-info pyfmt pylint python-x company-web helm-company company-anaconda company-jedi js2-refactor prettier-js exec-path-from-shell fullscreen-mode py-import-check py-isort pycomplete pydoc pyenv-mode python-django python-mode pyvenv pyvirtualenv flycheck expand-region neotree direx emmet-mode multi-web-mode web-mode multiple-cursors ido-vertical-mode projectile smex dark-krystal-theme flatui-dark-theme phoenix-dark-mono-theme phoenix-dark-pink-theme vscdark-theme zerodark-theme atom-dark-theme lsp-ui company-lsp lsp-mode evil evil-avy evil-visual-mark-mode company rainbow-delimiters paredit))
 '(pyenv-mode nil)
 '(pyvirtualenv-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(trash-directory "~/.emacs-trash/"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1d1f21" :foreground "#c5c8c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight bold :height 105 :width normal :foundry "pyrs" :family "MonacoB2"))))
 '(cursor ((t (:background "red1"))))
 '(fixed-pitch ((t (:family "MonacoB2"))))
 '(flycheck-error-list-highlight ((t nil)))
 '(header-line-highlight ((t nil)))
 '(highlight ((t (:background "turquoise4"))))
 '(line-number-current-line ((t (:inherit line-number :foreground "orange red"))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "cyan"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "light salmon"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "green yellow"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "lime green"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "dodger blue"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "MediumPurple1"))))
 '(rainbow-delimiters-depth-7-face ((t (:inherit rainbow-delimiters-base-face :foreground "pale goldenrod"))))
 '(region ((t (:background "dark slate gray")))))

(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            ;;(paredit-mode t)
            (rainbow-delimiters-mode t)
            (show-paren-mode 1)
            ))

(add-hook 'lisp-interaction-mode
          (lambda ()
            (paredit-mode t)
            (rainbow-delimiters-mode t)
            (show-paren-mode 1)
            ))
(require 'ielm)

(defun ielm/clear-repl ()
  "Clear current REPL buffer."
  (interactive)
  (let ((inhibit-read-only t))
      (erase-buffer)
      (ielm-send-input)))

(define-key inferior-emacs-lisp-mode-map
  (kbd "M-RET")
  #'ielm-return)

(define-key inferior-emacs-lisp-mode-map
  (kbd "C-j")
  #'ielm-return)

(define-key inferior-emacs-lisp-mode-map
  (kbd "RET")
  #'electric-newline-and-maybe-indent)

(define-key inferior-emacs-lisp-mode-map
  (kbd "<up>")
  #'previous-line)

(define-key inferior-emacs-lisp-mode-map
  (kbd "<down>")
  #'next-line)

(define-key inferior-emacs-lisp-mode-map
  (kbd "C-c C-q")
  #'ielm/clear-repl
  )

;; javscript
(package-install 'lsp-mode)

;;(require 'lsp-clients)

(add-hook 'js2-mode-hook 'lsp)
(add-hook 'dart-mode-hook 'lsp)

;; For dropdown autocomplete:
(package-install 'company)
(package-install 'company-lsp)
(require 'company)
(require 'company-lsp)
;;
;; For other fancy UI stuff:
(package-install 'lsp-ui)
(require 'lsp-ui)
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))

(add-hook 'js-mode-hook #'lsp)
(add-hook 'js-mode-hook #'prettier-js-mode)
(add-hook 'js-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")
(add-hook 'typescript-mode-hook #'lsp) ;; for typescript support
(add-hook 'js3-mode-hook #'lsp) ;; for js3-mode support
(add-hook 'rjsx-mode #'lsp) ;; for rjsx-mode support
;;(add-hook 'python-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp-deferred)

(setq-default indicate-empty-lines t)

(add-hook 'prog-mode-hook 'evil-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'subword-mode)
;;(add-hook 'html-mode-hook 'web-mode)

(add-hook 'web-mode-hook 'emmet-mode)


;; ido
;;(require 'ido-vertical-mode)
(ido-mode t)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(fset 'yes-or-no-p 'y-or-n-p)
(when window-system (set-fontset-font "fontset-default" '(#x600 . #x6ff) "Tahoma"))

;; اهلا بكم
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(put 'dired-find-alternate-file 'disabled nil)

(projectile-mode +1)
(projectile-global-mode)
(setq projectile-enable-caching t)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

				
(defun duplicate-current-line ()
  (interactive)
  (beginning-of-line nil)
  (let ((b (point)))
    (end-of-line nil)
    (copy-region-as-kill b (point)))
  (beginning-of-line 2)
  (open-line 1)
  (yank)
  (back-to-indentation))
(fullscreen-mode-fullscreen)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(setq lsp-ui-sideline-ignore-duplicate t)
;;(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(fset 'indent-html
   [?\C-x ?r ?w ?\] ?\C-x ?h ?\M-x ?i ?n ?d ?e ?n ?t ?- ?r ?e ?g ?i ?o ?n return ?\C-x ?r ?j ?\]])

(defun dart-mode-before-save-hook ()
  (when (eq major-mode 'dart-mode)
    (lsp-format-buffer)
    (flutter-hot-reload)))

(add-hook 'before-save-hook #'dart-mode-before-save-hook)

(global-flycheck-mode 1)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))



(add-to-list 'display-buffer-alist
             '("^\\*shell\\*$" . (display-buffer-same-window)))


(setq python-shell-interpreter "python3")


(add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load
 'company
 '(add-to-list 'company-backends 'company-omnisharp))

(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook #'flycheck-mode)
(setq create-lockfiles nil)


(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun toggle-php-flavor-mode ()
  (interactive)
  "Toggle mode between PHP & Web-Mode Helper modes"
  (cond ((string= mode-name "PHP")
         (web-mode))
        ((string= mode-name "Web")
         (php-mode))))

(global-set-key [f5] 'toggle-php-flavor-mode)

(defun bs-php-mode-hook ()
  (auto-complete-mode t)                 ;; «
  (require 'ac-php)                      ;; «
  (setq ac-sources  '(ac-source-php ))   ;; «
  (yas-global-mode 1)                    ;; «
  (setq indent-tabs-mode nil)
  (setq php-template-compatibility nil)
  (setq c-basic-offset 2))

(add-hook 'php-mode-hook 'bs-php-mode-hook)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(require 'clang-format)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)

;;(setq clang-format-style-option "Microsoft")

(defun clang-format-save-hook-for-this-buffer ()
  "Create a buffer local save hook."
  (add-hook 'before-save-hook
    (lambda ()
        (clang-format-buffer)
        (csharp-mode)
        ;; Continue to save.
        nil)
    nil
    ;; Buffer local hook.
    t))

;; Run this for each mode you want to use the hook.
(add-hook 'csharp-mode-hook (lambda () (clang-format-save-hook-for-this-buffer)))
(with-eval-after-load 'neotree
  (add-hook 'neotree-mode-hook
            (lambda()
	      (define-key evil-motion-state-local-map (kbd "TAB")  'neotree-stretch-toggle)
	      (define-key evil-motion-state-local-map (kbd "RET")  'neotree-enter)
	      (define-key evil-motion-state-local-map (kbd "|")    'neotree-enter-vertical-split)
	      (define-key evil-motion-state-local-map (kbd "-")    'neotree-enter-horizontal-split)
	      (define-key evil-motion-state-local-map (kbd "?")    'evil-search-backward)
	      (define-key evil-motion-state-local-map (kbd "c")    'neotree-create-node)
	      (define-key evil-motion-state-local-map (kbd "d")    'neotree-delete-node)
	      (define-key evil-motion-state-local-map (kbd "gr")   'neotree-refresh)
	      (define-key evil-motion-state-local-map (kbd "h")    'spacemacs/neotree-collapse-or-up)
	      (define-key evil-motion-state-local-map (kbd "H")    'neotree-select-previous-sibling-node)
	      (define-key evil-motion-state-local-map (kbd "J")    'neotree-select-down-node)
	      (define-key evil-motion-state-local-map (kbd "K")    'neotree-select-up-node)
	      (define-key evil-motion-state-local-map (kbd "l")    'spacemacs/neotree-expand-or-open)
	      (define-key evil-motion-state-local-map (kbd "L")    'neotree-select-next-sibling-node)
	      (define-key evil-motion-state-local-map (kbd "q")    'neotree-hide)
	      (define-key evil-motion-state-local-map (kbd "r")    'neotree-rename-node)
	      (define-key evil-motion-state-local-map (kbd "R")    'neotree-change-root)
	      (define-key evil-motion-state-local-map (kbd "s")    'neotree-hidden-file-toggle))
            )
  )
(defun csharp-disable-clear-string-fences (orig-fun &rest args)
  "This turns off `c-clear-string-fences' for `csharp-mode'. When
on for `csharp-mode' font lock breaks after an interpolated string
or terminating simple string."
  (unless (equal major-mode 'csharp-mode)
    (apply orig-fun args)))
(advice-add 'c-clear-string-fences :around 'csharp-disable-clear-string-fences)

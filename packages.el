;;; package --- package management

;;; Commentary:
;; using use-package

;;; Code:

;; bootstrap straight (https://github.com/raxod502/straight.el)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; https://github.com/jwiegley/use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t) ; replace use-package with straight-use-package

;; Use the :init keyword to execute code before a package is loaded.
;; :config can be used to execute code after a package is loaded.

;; needed to get LSP right
(straight-pull-package 'melpa)

;; actual packages

;; pretty icons (needed by several other packages)
(use-package all-the-icons)

;; complete anything (https://company-mode.github.io/)
(use-package company
  :hook (after-init-hook . global-company-mode))

(use-package diminish)

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-unicode-fallback t))

;; spell checking text modes and code comments
(use-package flyspell
  :init
  (setq ispell-program-name "aspell"
        ispell-list-command "--list")
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'text-mode-hook 'flyspell-mode)
  ;; fix mouse
  (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
  (define-key flyspell-mouse-map [mouse-3] #'undefined))

;; suggest keys
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))


(provide 'packages)
;;; packages.el ends here


; Follow symlinks on git managed files
(setq vc-follow-symlinks t)

;; start maximized
;(custom-set-variables
; '(initial-frame-alist (quote ((fullscreen . maximized)))))
(add-to-list 'default-frame-alist '(fullscreen . fullboth))


; load elpa packages dir
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

; shell flymake
(require 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)
; yaml flymake
(require 'flymake-yaml) ;; Not necessary if using ELPA package
(add-hook 'yaml-mode-hook 'flymake-yaml-load)
; puppt flymake
(require 'flymake-puppet)
; load pylint flymake config
(load-file "/usr/share/doc/pylint/elisp/pylint-flymake.el")

; Undo tree
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'undo-tree)
(global-undo-tree-mode)

; 80 cols handling
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
  '(lambda() (set-fill-column 80)))
(require 'column-enforce-mode)
(add-hook 'python-mode-hook 'column-enforce-mode)
(add-hook 'ruby-mode-hook 'column-enforce-mode)
(add-hook 'sh-mode-hook 'column-enforce-mode)

; emacs for python
(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")

; Git comments formatting
;(load-file "~/.emacs.d/elpa/git-commit-mode-20140605.520/git-commit-mode.el")
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)
(add-hook 'git-commit-mode-hook (lambda () (toggle-save-place 0)))
(add-hook 'git-commit-mode-hook 'column-enforce-mode)
; kill buffers on exit
(add-hook 'server-switch-hook
	  (lambda ()
	    (menu-bar-mode -1)))
(add-hook 'server-done-hook (lambda nil (kill-buffer nil)))
; avoid autorevert question on git commit --amend
;(global-auto-revert-mode 1)

; Search word under cursor
(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
  (setq highlight-symbol-on-navigation-p t)
  (global-set-key (kbd "C-n") 'highlight-symbol-next)
  (global-set-key (kbd "C-M-n") 'highlight-symbol-prev)

; goto
(require 'goto-chg)
  (global-set-key (kbd "C-b") 'goto-last-change)
  (global-set-key (kbd "C-M-b") 'goto-last-change-reverse)


;--------------------;
;;; User Interface ;;;
;--------------------;

; always use spaces, not tabs, when indenting
(setq indent-tabs-mode nil)

; ignore case when searching
(setq case-fold-search t)

; follow synlinks of control versioned files
(setq vc-follow-symlink t)

; require final newlines in files when they are saved
(setq require-final-newline t)

; window modifications
;(global-set-key (kbd "S-C-") 'shrink-window-horizontally)
;(global-set-key (kbd "S-C-") 'enlarge-window-horizontally)
;(global-set-key (kbd "S-C-") 'shrink-window)
;(global-set-key (kbd "S-C-") 'enlarge-window)

; set the keybinding so that you can use f4 for goto line
(global-set-key [f4] 'goto-line)

;----------------------;
;;; Windows & Frames ;;;
;----------------------;

; language
(setq current-language-environment "English")

; don't show the startup screen
(setq inhibit-startup-screen t)
; don't show the menu bar
(menu-bar-mode nil)
; don't show the tool bar
(require 'tool-bar)
(tool-bar-mode nil)
; don't show the scroll bar
(scroll-bar-mode nil)

; number of characters until the fill column
(setq fill-column 80)

; specify the fringe width for windows -- this sets both the left and
; right fringes to 10
(require 'fringe)
(fringe-mode 10)

; lines which are exactly as wide as the window (not counting the
; final newline character) are not continued. Instead, when point is
; at the end of the line, the cursor appears in the right fringe.
(setq overflow-newline-into-fringe t)

; each line of text gets one line on the screen (i.e., text will run
; off the left instead of wrapping around onto a new line)
(setq truncate-lines t)
; truncate lines even in partial-width windows
(setq truncate-partial-width-windows t)

; display line numbers to the right of the window
(global-linum-mode t)
; show the current line and column numbers in the stats bar as well
(line-number-mode t)
(column-number-mode t)

;------------;
;;; Cursor ;;;
;------------;
; highlight the current line
(require 'highlight-current-line)
(global-hl-line-mode t)
(setq highlight-current-line-globally t)
(setq highlight-current-line-high-faces nil)
(setq highlight-current-line-whole-line nil)
(setq hl-line-face (quote highlight))

; don't blink the cursor
(blink-cursor-mode nil)

; make sure transient mark mode is enabled (it should be by default,
; but just in case)
(transient-mark-mode t)

; turn on mouse wheel support for scrolling
(require 'mwheel)
(mouse-wheel-mode t)

;-------------------------;
;;; Syntax Highlighting ;;;
;-------------------------;

; text decoration
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(global-hi-lock-mode nil)
(setq jit-lock-contextually t)
(setq jit-lock-stealth-verbose t)

; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode t)

; highlight parentheses when the cursor is next to them
(require 'paren)
(show-paren-mode t)

;-----------------;
;;; Color Theme ;;;
;-----------------;

; make sure the frames have the dark background mode by default
(setq default-frame-alist (quote (
  (frame-background-mode . dark)
)))

; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

(setq-default show-trailing-whitespace t)
(defalias 'ttw 'tf-toggle-show-trailing-whitespace)
(defun tf-toggle-show-trailing-whitespace ()
    "Toggle show-trailing-whitespace between t and nil"
    (interactive)
    (setq show-trailing-whitespace (not show-trailing-whitespace))
    (redraw-display))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((t (:inherit nil :background "red"))))
 '(font-lock-comment-face ((t (:foreground "cyan" :slant italic))))
 '(font-lock-constant-face ((t (:foreground "blue"))))
 '(font-lock-function-name-face ((t (:foreground "green" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "blue" :weight bold))))
 '(font-lock-string-face ((t (:foreground "cyan"))))
 '(highlight ((t (:inverse-video t))))
 '(linum ((t (:inherit (shadow default) :foreground "yellow")))))

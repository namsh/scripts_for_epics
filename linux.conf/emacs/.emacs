; menu bar off
;(menu-bar-mode nil)

; tool bar off
;(tool-bar-mode nil)

(setq column-number-mode t)
; open .gz file
(auto-compression-mode t)

;; Paren highlighting
(require 'paren)
(show-paren-mode 1)

;; default to better frame titles
(setq frame-title-format (concat invocation-name "@" system-name ": %b %+%+ %f"))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(transient-mark-mode 1)

(setq org-log-done 'note)
(setq org-todo-keywords
      '((sequence "TODO" "PROGRESSING" "|" "DONE" "DELEGATED")))

;; see how to format
;; http://www.delorie.com/gnu/docs/elisp-manual-21/elisp_689.html
;; %A : This stands for the full name of the day of week. 
;; %B : This stands for the full name of the month. 
;; %e : This stands for the day of month, blank-padded. 
;; %H : his stands for the hour (00-23). 
;; %M : This stands for the minute (00-59). 
;; %S : This stands for the seconds (00-59). 
;; %Z : This stands for the time zone abbreviation. 
;; %Y : This stands for the year with century. 

(defvar insert-date-format "%A, %B %e %H:%M:%S %Z %Y")

(defun insert-date ()
  "Insert the current date"
  (interactive "*")
  (insert (format-time-string insert-date-format (current-time) ))
)


 
(global-set-key [?\S- ] 'toggle-input-method)
(global-set-key [f5] 'insert-date)

;; not necessary for 23-2 emacs
;;(global-set-key (kbd "C-x <left>") 'previous-buffer)
;;(global-set-key (kbd "C-x <right>") 'next-buffer)


;; handle color codes properly in shell enviroment into emacs shell

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; for emacs 23 or later

(setq tex-view "xdvi -watchfile 1 *")

(when window-system
   (set-face-font 'default "-outline-Droid Sans Mono-normal-normal-normal-mono-14-*-*-*-c-*-iso10646-1")
    (set-fontset-font "fontset-default" '(#x1100 . #xffdc)  '("나눔고딕코딩" . "unicode-bmp")) ;; 유니코드 한글영역
    (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)  '("나눔굴림" . "unicode-bmp")) ;; 유니코드 사용자 영역
)

;;(defadvice switch-to-buffer (after activate-input-method activate)
;; (activate-input-method "korean-hangul"))


;; (when window-system
;;   ;(set-face-font 'default "-outline-Courier New-normal-normal-normal-mono-16-*-*-*-c-*-iso10646-1")
;;   ;(set-face-font 'default "-outline-Bitstream Vera Sans Mono-normal-normal-normal-mono-16-*-*-*-c-*-iso10646-1")
;;   ;(set-face-font 'default "-outline-DejaVu Sans Mono-normal-normal-normal-mono-16-*-*-*-c-*-iso10646-1")
;;   ;  (set-face-font 'default "-outline-Droid Sans Mono-normal-normal-normal-mono-12-*-*-*-c-*-iso10646-1")
;;   ;(set-fontset-font "fontset-default" 'hangul '("malgun gothic" . "unicode-bmp"))
;;   ;(set-fontset-font "fontset-default" '(#x1100 . #xffdc)  '("malgun gothic" . "unicode-bmp")) ;; 유니코드 한글영역
;;   ;(set-fontset-font "fontset-default" 'kana '("ms mincho" . "unicode-bmp"))
;;   ;  (set-fontset-font "fontset-default" 'han '("ms mincho" . "unicode-bmp"))
;;    ;(set-fontset-font "fontset-default" 'cjk-misc '("ms mincho" . "unicode-bmp"))
;;   ; (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)  '("new gulim" . "unicode-bmp")) ;; 유니코드 사용자 영역
;;  )

;; ;;(defadvice switch-to-buffer (after activate-input-method activate)
;; ;;  (activate-input-method "korean-hangul")
;; ;;)

;;(load-file "$ROOTSYS/build/misc/root-help.el")
;;(require 'root-help)


;;(load-file "~/programs/ess/lisp/ess-site.el")
;;(require 'ess-site)


;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;;(load-file "~/programs/cedet/common/cedet.el")
;;(require 'semantic-load)


;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;;(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;;(semantic-load-enable-minimum-features);
;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 

;;(global-ede-mode 1)                      ; Enable the Project management system

;;(setq ede-arduino-appdir "/home/ctrluser/dev/arduino/")

;;(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
;;(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
;;(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)



;;(require 'semantic-ia)
;; Enable EDE for a pre-existing C++ project
;;(ede-cpp-root-project "QwAnalysisTrunk" :file "~/QwAnalysis/trunk/GNUmakefile")

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;;(global-srecode-minor-mode 1)

;;(require 'semantic-decorate-include)

;; ;; gcc setup
;;(require 'semantic-gcc)
;;(semantic-add-system-include "$ROOTSYS/include" 'c-mode)

;;(add-to-list 'load-path   "~/programs/ecb")


(load-file "$HOME/.emacs.d/protobuf-mode.el")
(require 'protobuf-mode)


(load-file "$HOME/.emacs.d/epics-mode.el")
(require 'epics-mode)



(require 'ecb)
;;(require 'edit-server)
;;(edit-server-start)






(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(doc-view-continuous t)
 '(ecb-auto-activate nil)
 '(ecb-compile-window-height nil)
 '(ecb-layout-window-sizes nil)
 '(ecb-new-ecb-frame nil)
 '(ecb-options-version "2.40")
 '(ecb-tree-buffer-style (quote image))
 '(ecb-tree-expand-symbol-before t)
 '(font-use-system-font t)
 '(inhibit-startup-screen t)
 '(ispell-personal-dictionary "~/.aspell.LANG.pws")
 '(ispell-skip-html t)
 '(safe-local-variable-values (quote ((TeX-master . t))))
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 99 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

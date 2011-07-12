
(show-paren-mode 1)
(setq load-path (append '("~/elisp/") load-path))
(add-to-list 'load-path "~/elisp/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/elisp//ac-dict")
(ac-config-default)
(column-number-mode t)
(line-number-mode t)
;;autoinstall
(add-to-list 'load-path (expand-file-name "~/elisp/autoinstall"))
(require 'auto-install)
(setq auto-install-directory "~/elisp/autoinstall/")
(auto-install-compatibility-setup)
;; テキストエンコーディングとしてUTF-8を優先使用
(prefer-coding-system 'utf-8)

;; 起動時のメッセージを非表示
(setq inhibit-startup-message t)
;;; *.~ とかのバックアップファイルを作らない
 (setq make-backup-files nil)
 ;;; .#* とかのバックアップファイルを作らない
 (setq auto-save-default nil)
;;twitter
;;(require 'twittering-mode)
(setq history-length t)
;; session.el
;;   kill-ringやミニバッファで過去に開いたファイルなどの履歴を保存する
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (add-hook 'after-init-hook 'session-initialize)
  ;; 前回閉じたときの位置にカーソルを復帰
  (setq session-undo-check -1))
;; minibuf-isearch
;;   minibufでisearchを使えるようにする
(require 'minibuf-isearch nil t)
;;ruby-mode

(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))
;; ;; ruby-electric.el
 (require 'ruby-electric)
 (add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; flymake for ruby
(require 'flymake)
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode))
    ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
    (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))

(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))
;;php-mode
(load-library "php-mode")
(require 'php-mode)

;; mmm-mode in php
    ;; (require 'mmm-mode)
    ;; (setq mmm-global-mode 'maybe)
    ;; (set-face-background 'mmm-default-submode-face "nil")
    ;; (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
    ;; (mmm-add-classes
    ;; '((html-php
    ;; :submode php-mode
    ;; :front "<\\?\\(php\\)?"
    ;; :back "\\?>")))
    ;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . xml-mode))
;;; mmm-mode
(require 'mmm-mode)
;(require 'mmm-auto)
(setq mmm-submode-decoration-level 2)
(invert-face 'mmm-default-submode-face t)
(setq mmm-font-lock-available-p t)
(setq mmm-global-mode 'maybe)
; (set-face-bold-p 'mmm-default-submode-face t)
;(set-face-background 'mmm-default-submode-face nil)
(mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
(mmm-add-classes
 '((html-php
    :submode php-mode
    :front "<\\?\\(php\\)?"
    :back "\\?>")))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . html-mode))
;; タブの改善
(defun save-mmm-c-locals ()
  (with-temp-buffer
    (php-mode)
    (dolist (v (buffer-local-variables))
      (when (string-match "\\`c-" (symbol-name (car v)))
        (add-to-list 'mmm-save-local-variables `(,(car v) nil, mmm-c-derived-modes))))))
(save-mmm-c-locals)
;;Rsense
(setq rsense-home (expand-file-name "~/elisp/rsense"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)
(setq rsense-rurema-home (concat rsense-home "/doc/ruby-refm"))
(setq rsense-rurema-refe "refe-1_9_2")
(add-hook 'ruby-mode-hook
          '(lambda ()
             ;; .や::を入力直後から補完開始
	     (add-to-list 'ac-sources 'ac-source-rsense-method)
	     (add-to-list 'ac-sources 'ac-source-rsense-constant)
	     ;; C-x .で補完出来るようキーを設定
             (define-key ruby-mode-map (kbd "C-c .") 'ac-complete-rsense)))

;;growl
(when (executable-find "growlnotify")
  (defun growlnotify-after-save-hook ()
    (shell-command
     (format
      "growlnotify -a \"Emacs\" -t \"バッファを保存\" -m \"%s\""
      (buffer-name (current-buffer)))))

  ;; 関数をafter-save-hookに追加する
  (add-hook 'after-save-hook 'growlnotify-after-save-hook))

;; ;;anything
 (require 'anything)
(defvar org-directory "")
(require 'anything-startup)

(global-set-key "\M-n" 'linum-mode)

(set-face-attribute 'default nil :family "Ricty" :height 140)

;;ruby実行
(defun execute-ruby-whole-buffer ()
  (interactive)
  (let (buf)
    (save-excursion
      (setq buf (get-buffer-create "*result ruby execution*"))
      (mark-whole-buffer)
      (call-process-region (region-beginning) (region-end) "ruby" nil buf nil)
      (display-buffer buf))))

(define-key ruby-mode-map (kbd "C-p")'execute-ruby-whole-buffer)
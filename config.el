;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-mister)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; set font
(setq doom-font (font-spec :family "FiraCode" :size 16 :weight 'medium))

(custom-set-faces
 '(region ((t :extend nil))))

;; blink this shit
(blink-cursor-mode t)

;; block cursor >>>>
(setq evil-insert-state-cursor '(box))

;; shell command
(map! :leader ("e" #'shell-command))

;; create splits
(map! :leader
      :desc "Split window vertically"   "w|" #'split-window-right
      :desc "Split window horizontally" "w-" #'split-window-below)

;; fuck decoration
(setq font-lock-maximum-decoration 'minimal)

;; relative line numbers
(setq display-line-numbers-type 'relative)

;; fuck line mode man
(setq global-hl-line-modes nil)

;; unnamed plus ma man
(setq select-enable-clipboard nil)

;; copy to clipboard
(map! :leader
      "y" #'(lambda () (interactive)
              (if (use-region-p)
                  (progn
                    (clipboard-kill-ring-save (region-beginning) (region-end))
                    (deactivate-mark))
                (clipboard-kill-ring-save (line-beginning-position) (line-end-position)))))

;; yank from clipboard
(map! :map general-override-mode-map
      "C-S-v" #'(lambda() (interactive)
                  (if (display-graphic-p)
                      (clipboard-yank)
                    (insert-for-yank (gui-get-primary-selection)))))

(setq confirm-kill-emacs nil)

;; open file in split screen
(after! dired
  (map! :map dired-mode-map
        :n "C-<return>" (lambda ()
                          (interactive)
                          (let ((split-width-threshold nil)
                                (split-height-threshold 0))
                            (dired-find-file-other-window)))))

;; rezise windows
(map! :map global-map
      "C-<left>" (lambda () (interactive) (shrink-window-horizontally 2))
      "C-<right>" (lambda () (interactive) (enlarge-window-horizontally 2))
      "C-<down>" (lambda () (interactive) (shrink-window 2))
      "C-<up>" (lambda () (interactive) (enlarge-window 2)))

(setq ido-show-dot-for-dired t)

;; redo
(map! :map global-map
      :n "U" #'undo-redo)

(map! :leader ("tt" #'neotree-toggle))
(map! :leader ("td" #'neotree-dir))

(setq neo-window-position '(right))

(after! org
  (setq org-hide-emphasis-markers t))

(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :config
  (setq pdf-view-midnight-colors '("#ABB2BF" . "#282C35")))

;; footer message
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "yes it's fucking mister clayton")))

;; remove sections on dashboard
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; dashboard pic
(setq fancy-splash-image "~/.config/doom/images/mark.png")

;; tree
(setq treemacs-position 'right)

;; go error
(defun insert-go-error-check ()
  (interactive)
  (insert "if err != nil {\n\treturn\n}\n"))

(after! evil
  (map! :leader
        :desc "Insert Go error check"
        "ge" #'insert-go-error-check))

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom sync' after modifying this file!


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
;; (setq doom-font (font-spec :family "Fira Code SemiBold" :size 12)
;;       doom-variable-pitch-font (font-spec :family "Fira Code SemiBold" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'gruber-darker)
;; (setq doom-theme 'doom-rose-pine)

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

;; (setq doom-font (font-spec :family "Consolas-13"))

;; blink the cursor
(blink-cursor-mode t)

;; rainbow mode
;; (use-package rainbow-mode
;;   :hook (emacs-lisp-mode text-mode lisp-mode))

;; block cursor >>>
;; (setq evil-insert-state-cursor '(box))

;; shell command
(map! :leader ("e" #'shell-command))

;; create splits
(map! :leader
      :desc "Split window vertically"   "w|" #'split-window-right
      :desc "Split window horizontally" "w-" #'split-window-below)

;; guts background
(setq fancy-splash-image "~/.config/doom/images/guts.jpg")

;; fuck decoration
(setq font-lock-maximum-decoration 'minimal)

;; footer message
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "do not pass unless you are mister")))

;; remove sections on dashboard
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

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


(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)

;; move text
(map! :map global-map
      "M-k" #'move-text-up
      "M-j" #'move-text-down)

;; In ~/.doom.d/config.el

;; Set default indentation to 2 spaces for various common programming and markup languages
(setq-default tab-width 2
              standard-indent 2
              indent-tabs-mode nil) ; Prefer spaces over tabs

;; Specific mode adjustments
(after! js2-mode
  (setq js2-basic-offset 2)) ; JavaScript and derived modes like JSX

(after! typescript-mode
  (setq typescript-indent-level 2)) ; TypeScript

(after! python
  (setq python-indent-offset 2)) ; Python

(after! css-mode
  (setq css-indent-offset 2)) ; CSS and derived modes like SCSS

(after! html-mode
  (setq sgml-basic-offset 2) ; HTML
  web-mode-markup-indent-offset 2) ; Web mode for HTML templates

(after! yaml-mode
  (setq yaml-indent-offset 2)) ; YAML

(after! json-mode
  (setq js-indent-level 2)) ; JSON

;; You can add similar settings for other modes as needed

;; Ensure that spaces are used by default instead of tabs
(setq-default indent-tabs-mode nil)

;; Hook for programming modes (applies to most programming languages)
(add-hook 'prog-mode-hook (lambda () (setq indent-tabs-mode nil tab-width 2)))

;; Hook for text modes
(add-hook 'text-mode-hook (lambda () (setq indent-tabs-mode nil tab-width 2)))

;; tailwind
;; (use-package! lsp-tailwindcss)

;; execute tsserver for the love of christ
(setq lsp-clients-typescript-server (executable-find "tsserver"))

;; fuck that emacs confirmation stuff
(setq confirm-kill-emacs nil)

;; obsidian stuff
(use-package obsidian
  :ensure t
  :demand t
  :config
  (obsidian-specify-path "~/the berserk")
  (global-obsidian-mode t)
  :custom
  ;; The directory for daily notes (file name is YYYY-MM-DD.md)
  (obsidian-daily-notes-directory "journal")
  ;; Directory of note templates, unset (nil) by default
  (obsidian-templates-directory "templates")
  ;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
  (setq obsidian-daily-note-template "daily_note_template.md")
  :bind (:map obsidian-mode-map
              ;; Replace C-c C-o with Obsidian.el's implementation. It's ok to use another key binding.
              ("C-c C-o" . obsidian-follow-link-at-point)
              ;; Jump to backlinks
              ("C-c C-b" . obsidian-backlink-jump)
              ;; If you prefer you can use `obsidian-insert-link'
              ("C-c C-l" . obsidian-insert-wikilink)))


;; minions mode
(add-hook 'emacs-startup-hook (lambda () (minions-mode 1)))

;; obsidian mappings ma man
(map! :leader
      :desc "obsidian today"   "ot" #'obsidian-daily-note
      :desc "obsidian search"   "of" #'obsidian-jump
      :desc "obsidian goto"   "od" #'obsidian-follow-link-at-point
      :desc "obsidian link"   "ol" #'obsidian-insert-link
      :desc "obsidian tags"   "os" #'obsidian-tag-find)

;; Enable whitespace mode globally
;; (global-whitespace-mode +1)

;; Configure whitespace-mode to show dots for spaces
;; (setq whitespace-style '(face spaces tabs newline space-mark tab-mark newline-mark))

;; (setq whitespace-display-mappings
;; '((space-mark 32 [183] [46])
;; (tab-mark 9 [187 9] [92 9])
;; (newline-mark 10 [182 10] [92 10])))

;; You might need to adjust the characters/symbols used for display according to your preferences

;; (setq whitespace-style (remq 'newline whitespace-style))
;; (setq whitespace-style (remq 'newline-mark whitespace-style))

;; accept completion from copilot and fallback to company
;; (use-package! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; (setq copilot-indent-offset-warning-disable t)

(setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'medium))

;; prisma mode
(use-package! prisma-mode)
(setq prisma-format-on-save t)

;; turn off whitespace mode
(advice-add #'doom-highlight-non-default-indentation-h :override #'ignore)

(map! :v "$" #'end-of-line)

;;; doom-homage-black-theme.el --- a minimalistic, colorless theme inspired by eziam, tao, and jbeans -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: February 4, 2021 (#497)
;; Author: mskorzhinskiy <https://github.com/mskorzhinskiy>
;; Maintainer:
;; Source: original
;;
;;; Commentary:
;;
;; Theme is (manually) inverted homage-white theme with a focus of having
;; pitch-black backgrounds. I'm also incorporated a several ideas from jbeans
;; theme (synic/jbeans-emacs).
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-homage-black-theme nil
  "Options for the `doom-homage-black' theme."
  :group 'doom-themes)

(defcustom doom-homage-black-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-homage-black-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-mister
                "the chaddest of all."

                ;; name        default   256       16
                ((bg         '("#1c1c1c" nil       nil            ))
                 (bg-alt     '("#1c1c1c" nil       nil            ))
                 (base0      '("#1c1c1c" "black"   "black"        ))
                 (base1      '("#2e2e2e" "#1e1e1e" "brightblack"  ))
                 (base2      '("#373737" "#2e2e2e" "brightblack"  ))
                 (base3      '("#414141" "#262626" "brightblack"  ))
                 (base4      '("#4a4a4a" "#3f3f3f" "brightblack"  ))
                 (base5      '("#555555" "#525252" "brightblack"  ))
                 (base6      '("#606060" "#6b6b6b" "brightblack"  ))
                 (base7      '("#6c6c6c" "#979797" "brightblack"  ))
                 (base8      '("#797979" "#dfdfdf" "white"        ))
                 (fg         '("#c7c7c7" "#bfbfbf" "brightwhite"  ))
                 (fg-alt     '("#a1a1a1" "#2d2d2d" "white"        ))

                 (grey       '("#525252"))
                 (red        '("#733434" "#ff6655" "red"          ))
                 (orange     '("#806d4e" "#b4916d" "brightred"    ))
                 (green      '("#5f7d5f" "#99bb66" "green"        ))
                 (teal       '("#4b7573" "#44b9b1" "brightgreen"  ))
                 (yellow     '("#7d7b52" "#ECBE7B" "yellow"       ))
                 (blue       '("#4e718d" "#0170bf" "brightblue"   ))
                 (dark-blue  '("#3b4e66" "#0170bf" "blue"         ))
                 (magenta    '("#7d4e83" "#c678dd" "brightmagenta"))
                 (violet     '("#6d5e8d" "#a9a1e1" "magenta"      ))
                 (cyan       '("#4d7b7b" "#46D9FF" "brightcyan"   ))
                 (dark-cyan  '("#466970" "#5699AF" "cyan"         ))

                 ;; face categories -- required for all themes
                 (highlight      blue)
                 (vertical-bar   (doom-darken base2 0.1))
                 (selection      dark-blue)
                 (builtin        fg)
                 (comments       green)
                 (doc-comments   (doom-darken comments 0.15))
                 (constants      fg)
                 (functions      fg)
                 (keywords       blue)
                 (methods        fg)
                 (operators      fg)
                 (type           fg)
                 (strings        orange)
                 (variables      fg)
                 (numbers        orange)
                 (region         `(,(doom-darken (car dark-blue) 0.1) ,@(doom-darken (cdr base0) 0.3)))
                 (error          red)
                 (warning        yellow)
                 (success        green)
                 (vc-modified    orange)
                 (vc-added       green)
                 (vc-deleted     red)

                 ;; custom categories
                 (-modeline-bright t)
                 (-modeline-pad
                  (when doom-homage-black-padded-modeline
                    (if (integerp doom-homage-black-padded-modeline) doom-homage-black-padded-modeline 4)))

                 (modeline-fg     'unspecified)
                 (modeline-fg-alt (doom-blend violet base4 (if -modeline-bright 0.5 0.2)))

                 (modeline-bg
                  (if -modeline-bright
                      (doom-darken base2 0.05)
                    base1))
                 (modeline-bg-l
                  (if -modeline-bright
                      (doom-darken base2 0.1)
                    base2))
                 (modeline-bg-inactive (doom-darken bg 0.1))
                 (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.05) ,@(cdr base1))))

  ;;;; Base theme face overrides
                ((font-lock-builtin-face       :inherit 'bold :foreground base8)
                 ((font-lock-doc-face &override) :slant 'italic)
                 (font-lock-function-name-face :inherit 'bold :foreground base8)
                 (font-lock-keyword-face       :inherit 'bold :foreground "#4e718d")
                 (font-lock-type-face          :inherit 'bold :foreground base8)
                 ((hl-line &override) :background (doom-darken highlight 0.75))
                 ((line-number &override) :foreground (doom-lighten base4 0.15))
                 ((line-number-current-line &override) :foreground base8)
                 (mode-line
                  :background modeline-bg :foreground modeline-fg
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
                 (mode-line-inactive
                  :background modeline-bg-inactive :foreground modeline-fg-alt
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
                 (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))
                 (tooltip :background base1 :foreground fg)
                 ((secondary-selection &override) :background base0)
                 ((tree-sitter-hl-face:function.call &override) :foreground (doom-color 'fg))
                 ((tree-sitter-hl-face:variable &override) :foreground (doom-color 'fg))
                 ((tree-sitter-hl-face:keyword &override) :foreground blue :weight 'bold)
                 (cursor :background "#dbdbdb") ;; Replace #color with the hex color for the cursor
                 ((line-number-current-line &override) :foreground "#c7c7c7" :background "#2e2e2e") ;; Dark gray line numbers for the current line
                 ((tree-sitter-hl-face:function.method.call &override) :foreground "#4e718d") ;; This should match the color used for function declarations
                 ((tree-sitter-hl-face:property &override) :foreground "#4e718d") ;; This should match the color used for function declarations
                 ((region &override) :background "#3b4e66" :foreground nil :extend nil)


   ;;;; centaur-tabs
                 (centaur-tabs-unselected :background bg-alt :foreground base4)
   ;;;; css-mode <built-in> / scss-mode
                 (css-proprietary-property :foreground orange)
                 (css-property             :foreground green)
                 (css-selector             :foreground blue)
   ;;;; doom-modeline
                 (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   ;;;; ediff <built-in>
                 (ediff-current-diff-A        :foreground red   :background (doom-lighten red 0.8))
                 (ediff-current-diff-B        :foreground green :background (doom-lighten green 0.8))
                 (ediff-current-diff-C        :foreground blue  :background (doom-lighten blue 0.8))
                 (ediff-current-diff-Ancestor :foreground teal  :background (doom-lighten teal 0.8))
   ;;;; magit
                 ((magit-diff-hunk-heading           &override) :foreground fg    :background bg-alt :bold bold)
                 ((magit-diff-hunk-heading-highlight &override) :foreground base8 :background bg-alt :bold bold)
                 (magit-blame-heading     :foreground orange :background bg-alt)
                 (magit-diff-removed :foreground (doom-darken red 0.2) :background (doom-blend red bg 0.1))
                 (magit-diff-removed-highlight :foreground red :background (doom-blend red bg 0.2) :bold bold)
   ;;;; markdown-mode
                 (markdown-markup-face     :foreground base5)
                 (markdown-header-face     :inherit 'bold :foreground red)
                 ((markdown-code-face &override)       :background base1)
                 (mmm-default-submode-face :background base1)
   ;;;; mu4e
                 (mu4e-highlight-face :background bg :inherit 'bold)
   ;;;; helm
                 (helm-candidate-number :background blue :foreground bg)
   ;;;; ivy
                 ;; bg/fg are too close
                 ((ivy-minibuffer-match-face-1 &override) :foreground (doom-lighten grey 0.70))
   ;;;; ivy-posframe
                 (ivy-posframe               :background base0)
   ;;;; lsp-mode
                 (lsp-ui-doc-background      :background base0)
                 (lsp-face-highlight-read    :background (doom-blend red bg 0.3))
                 (lsp-face-highlight-textual :inherit 'lsp-face-highlight-read)
                 (lsp-face-highlight-write   :inherit 'lsp-face-highlight-read)
   ;;;; outline <built-in>
                 ((outline-1 &override) :foreground fg)
                 ((outline-2 &override) :foreground fg)
                 ((outline-3 &override) :foreground fg)
                 ((outline-4 &override) :foreground fg)
                 ((outline-5 &override) :foreground fg)
                 ((outline-6 &override) :foreground fg)
                 ((outline-7 &override) :foreground fg)
                 ((outline-8 &override) :foreground fg)
   ;;;; org <built-in>
                 ;; make unfinished cookie & todo keywords bright to grab attention
                 ((org-todo &override) :foreground red)
                 ;; make tags and dates to have pretty box around them
                 ((org-tag &override)   :foreground fg :background base1
                  :box `(:line-width -1 :color ,base5 :style 'released-button))
                 ((org-date &override)  :foreground fg :background base1
                  :box `(:line-width -1 :color ,base5  :style 'released-button))
                 ;; Make drawers and special keywords (like scheduled) to be very bleak
                 ((org-special-keyword &override)  :foreground grey)
                 ((org-drawer          &override)  :foreground grey)
                 ;; Make ellipsis as bleak as possible and reset underlines/boxing
                 (org-ellipsis :underline nil :box nil :foreground fg :background bg)
                 ;; Make blocks have a slightly different background
                 ((org-block &override) :background base1)
                 ((org-block-begin-line &override) :foreground fg :slant 'italic)
                 ((org-quote &override) :background base1)
                 ((org-table &override) :foreground fg)
                 ;; org-agendamode: make "unimportant" things like distant deadlines and
                 ;; things scheduled for today to be bleak.
                 (org-upcoming-deadline         :foreground base8)
                 (org-upcoming-distant-deadline :foreground fg)
                 (org-scheduled                 :foreground fg)
                 (org-scheduled-today           :foreground fg)
                 (org-scheduled-previously      :foreground base8)
   ;;;; solaire-mode
                 (solaire-mode-line-face
                  :inherit 'mode-line
                  :background modeline-bg-l
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
                 (solaire-mode-line-inactive-face
                  :inherit 'mode-line-inactive
                  :background modeline-bg-inactive-l
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   ;;;; swiper
                 ;; bg/fg are too close
                 ((swiper-match-face-1 &override) :background fg        :foreground bg)
                 ((swiper-line-face    &override) :background dark-blue :foreground fg)
   ;;;; web-mode
                 (web-mode-current-element-highlight-face :background dark-blue :foreground bg)
   ;;;; wgrep <built-in>
                 (wgrep-face :background base1))

  ;;;; Base theme variable overrides-
                ())

(provide 'doom-mister-theme)
;;; doom-homage-black-theme.el ends here

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Damien Gonot"
      user-mail-address "damien.gonot@gmail.com"
      doom-theme 'doom-one
      display-line-numbers-type 'relative
      projectile-project-search '("~/dev/")
      calendar-week-start-day 1
      display-time-24hr-format t)

(display-time-mode 1)

(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))

(defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)

(defun today () (interactive) (insert (format-time-string "%Y-%m-%d")))
(defun today-with-time () (interactive) (insert (format-time-string "%Y-%m-%d %H:%M")))
(defun timestamp () (interactive) (insert (format-time-string "%H:%M")))

(map! :leader
      :desc "Add ISO 8601 date"
      :n "i d" #'today)

(map! :leader
      :desc "Add ISO 8601 date and time"
      :n "i D" #'today-with-time)

(map! :leader
      :desc "Add timestamp"
      :n "i t" #'timestamp)

(use-package! org-fancy-priorities
              :hook (org-mode . org-fancy-priorities-mode)
              :config (setq org-fancy-priorities-list '((?A . "HIGH")
                                                        (?B . "MEDIUM")
                                                        (?C . "LOW"))))
(after! org
        (setq org-directory "~/meworg"
              org-cycle-separator-lines 1
              org-default-notes-file (concat org-directory "/notes.org")
              org-agenda-files (list (concat org-directory "/personal.org") (concat org-directory "/gcal_personal.org"))
              org-todo-keywords '((sequence "IDEA(i)" "TODO(t)" "PROGRESS(p)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
              org-todo-keyword-faces '(("IDEA" . "mediumpurple1")
                                       ("TODO" . "turquoise2")
                                       ("PROGRESS" . "chartreuse2")
                                       ("WAITING" . "grey42")
                                       ("DONE" . "grey42")
                                       ("CANCELLED" . "grey42"))
              org-journal-dir (concat org-directory "/journal/daily")
              org-journal-date-prefix "#+title: "
              org-journal-date-format "%Y-%m-%d"
              org-journal-file-format "%Y-%m-%d.org"
              org-journal-time-prefix "\n* "
              org-journal-hide-entries-p nil
              org-babel-clojure-backend 'cider
              org-link-file-path-type 'relative
              org-roam-directory org-directory
              +org-roam-open-buffer-on-find-file nil
              deft-directory org-directory
              deft-extensions '("org")
              deft-recursive t))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("letter"
                 "\\documentclass{letter}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

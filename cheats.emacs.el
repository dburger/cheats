;; M-x {query-}replace-regexp
;; with: \# 0 indexed number of replacement

;; M-x {query-}replace-regexp
;; \,(upcase (concat \1 "_" \2)) ;; use lisp function in replacement against grouping
;; \& entire string that matched

;; set character encoding
;; C-x ret f

;; edit a keyboard macro
;; C-x C-k

;; launch and go to line 42
;; emacs +42 document.txt

;; jump to last mark
;; C-u C-<space>

;; enter a <return> for search, replace, etc.,
;; C-q C-j

;; proced is dired for processes

;; this is an example I cooked up designed to be called in batch mode to
;; exploit emacs scritability from an external program, how to invoke
;; below:
(defun c-indent-file (filename)
  (interactive)
  (find-file filename)
  (mark-whole-buffer)
  (c-indent-line-or-region)
  (save-buffer))

;; would be invoked as:
emacs --batch -l '/home/dburger/.emacs' --eval '(c-indent-file "/home/dburger/test.c")'

;; determine indentation syntactic component for line C-c C-s
;; ((statement-cont 1710))
;; then set a function for it
(setq c-basic-offset 2)
(c-set-offset 'statement-cont '++)
;; other identifiers and what they equal
;; +   `c-basic-offset' times 1
;; -   `c-basic-offset' times -1
;; ++  `c-basic-offset' times 2
;; --  `c-basic-offset' times -2
;; *   `c-basic-offset' times 0.5
;; /   `c-basic-offset' times -0.5

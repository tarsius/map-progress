;;; map-progress.el --- mapping macros that report progress

;; Copyright (C) 2010-2012  Jonas Bernoulli

;; Author: Jonas Bernoulli <jonas@bernoul.li>
;; Created: 20100714
;; Version: 0.4.0
;; Homepage: https://github.com/tarsius/map-progress/
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'cl)
(require 'map-progress)

(defmacro mapcan-with-progress-reporter (msg fn seq &optional min max &rest rest)
  "Like `mapcan' but report progress in the echo area.
There may be only one SEQUENCE.  Also see `make-progress-reporter'.

\(fn MESSAGE FUNCTION SEQUENCE [MIN-VALUE MAX-VALUE CURRENT-VALUE MIN-CHANGE MIN-TIME])"
  `(map-with-progress-reporter ,msg 'mapcan ,fn ,seq ,min ,max ,@rest))

(defmacro mapcon-with-progress-reporter (msg fn seq &optional min max &rest rest)
  "Like `mapcon' but report progress in the echo area.
There may be only one SEQUENCE.  Also see `make-progress-reporter'.

\(fn MESSAGE FUNCTION SEQUENCE [MIN-VALUE MAX-VALUE CURRENT-VALUE MIN-CHANGE MIN-TIME])"
  `(map-with-progress-reporter ,msg 'mapcon ,fn ,seq ,min ,max ,@rest))

(defmacro mapl-with-progress-reporter (msg fn seq &optional min max &rest rest)
  "Like `mapl' but report progress in the echo area.
There may be only one SEQUENCE.  Also see `make-progress-reporter'.

\(fn MESSAGE FUNCTION SEQUENCE [MIN-VALUE MAX-VALUE CURRENT-VALUE MIN-CHANGE MIN-TIME])"
  `(map-with-progress-reporter ,msg 'mapl ,fn ,seq ,min ,max ,@rest))

(defmacro maplist-with-progress-reporter (msg fn seq &optional min max &rest rest)
  "Like `maplist' but report progress in the echo area.
There may be only one SEQUENCE.  Also see `make-progress-reporter'.

\(fn MESSAGE FUNCTION SEQUENCE [MIN-VALUE MAX-VALUE CURRENT-VALUE MIN-CHANGE MIN-TIME])"
  `(map-with-progress-reporter ,msg 'maplist ,fn ,seq ,min ,max ,@rest))

(defmacro dolist-with-progress-reporter (spec message &rest body)
  "Loop over a list and report progress in the echo area.
Evaluate BODY with VAR bound to each `car' from LIST, in turn.
Then evaluate RESULT to get return value, default nil.
An implicit nil block is established around the loop.

At each iteration MESSAGE followed by progress percentage is
printed in the echo area.  After the loop is finished, MESSAGE
followed by word \"done\" is printed.  This macro is a
convenience wrapper around `make-progress-reporter' and friends.

\(fn (VAR LIST [RESULT]) MESSAGE BODY...)"
  (let ((temp (make-symbol "--cl-dolist-temp--"))
        (temp2 (make-symbol "--cl-dolist-temp2--"))
        (temp3 (make-symbol "--cl-dolist-temp3--")))
    (set temp3 (length (nth 1 spec)))
    ;; FIXME: Copy&pasted from subr.el.
    `(block nil
       ;; This is not a reliable test, but it does not matter because both
       ;; semantics are acceptable, tho one is slightly faster with dynamic
       ;; scoping and the other is slightly faster (and has cleaner semantics)
       ;; with lexical scoping.
       ,(if lexical-binding
            `(let ((,temp ,(nth 1 spec))
                   (,temp2 (make-progress-reporter ,message 0 ,temp3)))
               (while ,temp
                 (let ((,(car spec) (car ,temp)))
                   ,@body
                   (setq ,temp (cdr ,temp))
                   (progress-reporter-update ,temp2 (- ,temp3 (length ,temp)))))
               (progress-reporter-done ,temp2)
               ,@(if (cdr (cdr spec))
                     ;; FIXME: This let often leads to "unused var" warnings.
                     `((let ((,(car spec) nil)) ,@(cdr (cdr spec))))))
          `(let ((,temp ,(nth 1 spec))
                 (,temp2 (make-progress-reporter ,message 0 ,temp3))
                 ,(car spec))
             (while ,temp
               (setq ,(car spec) (car ,temp))
               ,@body
               (setq ,temp (cdr ,temp))
               (progress-reporter-update ,temp2 (- ,temp3 (length ,temp))))
             (progress-reporter-done ,temp2)
             ,@(if (cdr (cdr spec))
                   `((setq ,(car spec) nil) ,@(cddr spec))))))))

(provide 'map-progress-cl)
;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; map-progress.el ends here

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

(provide 'map-progress-cl)
;; Local Variables:
;; indent-tabs-mode: nil
;; byte-compile-warnings: (not cl-functions)
;; End:
;;; map-progress.el ends here

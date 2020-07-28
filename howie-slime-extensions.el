;;; -*- Mode: emacs-lisp -*-

;;; slime-repl.el ---
;;; -*- Mode: Emacs-lisp -*-

;;; slime-repl.el ---
;;
;; Original Author: Helmut Eller
;; Contributors: too many to mention
;; License: GNU GPL (same license as Emacs)
;;
;;; Description:
;;  This hook extends the functionality of the :write-string event
;;  If the first word after :write-string in the event is :to-buffer
;;  then the next argument is the buffer name followed by the string
;;  This then writes the string to the named buffer (creating it if necessary).
;;  Otherwise this hook just passes on to the main hook.


(require 'slime)
(require 'slime-parse)
(require 'cl-lib)
(eval-when-compile (require 'cl))

(defun howie-slime-repl-event-hook-function (event)
  ;; Add a handler for write-string-to-buffer
  ;; (slime-log-event (list :howie-handler event))
  (slime-dcase event
    ((:write-string keyword &optional buffer-name output)
     (case keyword
      (:to-buffer
       (with-output-to-temp-buffer buffer-name
	 (princ output))
       ;;return to T to say we handled it
       t)
      ;; return nil to say we're passing, maybe another hook will handle it
      (otherwise nil)))
    ;; if it's not a :write-string event just pass it on to the next hook
    (t nil)))

(add-hook 'slime-event-hooks 'howie-slime-repl-event-hook-function)








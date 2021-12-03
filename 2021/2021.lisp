(in-package :cl-user)
(defpackage :aoc-2021
  (:use :cl)
  (:import-from :uiop :split-string))
(in-package :aoc-2021)

(defun 1a (f)
  (with-open-file (in f)
    (when in
      (loop for last-num = 9999
              then (when line (parse-integer line))
            for line = (read-line in nil nil)
            for cur-num = (when line (parse-integer line))

            while line

            count (> cur-num last-num) into increases
            finally (progn (close in)
                           (return increases))))))

(defun 1b (f)
  (with-open-file (in f)
    (when in
      (loop for last-sum = 99999 then cur-sum
            for a = 0 then b
            for b = 0 then c
            for line = (read-line in nil "0")
            for c = (when line (parse-integer line))
            for cur-sum = 99999 then (if (and (/= a 0)
                                              (/= b 0)
                                              (/= c 0))
                                         (+ a b c)
                                         99999)

            until (eq line "0")


            count (> cur-sum last-sum) into increases
            finally (progn (close in)
                           (return increases))))))

(defun 2a (f)
  (declare )
  (with-open-file (in f)
    (when in
      (let ((depth 0)
            (distance 0))
        (loop for line = (read-line in nil)
              for (dir step-string) = (when line (uiop:split-string line))
              for steps = (when line (parse-integer step-string :junk-allowed t))

              while line

              do (cond
                   ((equal dir "forward") (incf distance steps))
                   ((equal dir "down") (incf depth steps))
                   ((equal dir "up") (decf depth steps))))
        (* depth distance)))))


(defun 2b (f)
  (declare )
  (with-open-file (in f)
    (when in
      (let ((depth 0)
            (distance 0)
            (aim 0))
        (loop for line = (read-line in nil)
              for (dir step-string) = (when line (uiop:split-string line))
              for steps = (when line (parse-integer step-string :junk-allowed t))

              while line

              do (cond
                   ((equal dir "forward") (progn (incf distance steps)
                                                 (incf depth (* aim steps))))
                   ((equal dir "down") (incf aim steps))
                   ((equal dir "up") (decf aim steps))))
        (* depth distance)))))

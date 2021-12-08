(in-package :cl-user)
(defpackage :aoc-2021
  (:use :cl)
  (:import-from :uiop :split-string))
(in-package :aoc-2021)

(defun 1a (f)
  "How many lines are a higher number than the previous?"
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
  "How many 3-line sums increase from the previous?"
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
  "Given a list of submarine directions, determine depth and distance from origin."
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
  "2a, but up/down adjust aim."
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

(defun int<-bit-vector (bv)
  "Converts a bit vector to an integer"
  (reduce (lambda (&optional (acc 0) (b 0)) (+ b (ash acc 1))) bv))

(defun 3a (f)
  "Determine most common bit for each position in line, then multiply it by its xor."
  (with-open-file (in f)
    (when in
      (do* ((line (read-line in nil) (read-line in nil))
            (len (length line) len)
            (acc (make-array (list len) :element-type 'integer :initial-element 0) acc)
            (lines 0 (1+ lines)))
           ((null line)
            ;; finally
            (let* ((gamma (map 'bit-vector
                               (lambda (x)
                                 "If it shows up in more than half of the lines,
                                  it's the majority. This is ok because binary."
                                 (if (>= (/ x lines) 1/2)
                                     1
                                     0))
                               acc))
                   (epsilon (bit-xor gamma
                                     (make-array (list len)
                                                 :element-type 'bit
                                                 :initial-element 1))))
              (* (int<-bit-vector gamma) (int<-bit-vector epsilon))))
        (dotimes (i len)
          (when (char= #\1 (elt line i))
            (incf (elt acc i))))))))

(defstruct (jbbt (:constructor create-jbbt (data left right)))
  "Just your basic bi-nary tree."
  (data 0)
  (left nil)
  (right nil))

(defun jbbt-grow (str node)
  "Grafts a binary string onto the tree, counting occurrences.

   There should be away to tidy this more, but I've not figured out macrolet scoping I guess."
  (when (> (length str) 0)
    (let ((bit (elt str 0)))
      (if (char= #\0 bit)
          (progn
            (if (jbbt-left node)
                (incf (jbbt-data (jbbt-left node)))
                (setf (jbbt-left node)
                      (create-jbbt 1 nil nil)))
            (jbbt-grow (subseq str 1)
                       (jbbt-left node)))
          (progn
            (if (jbbt-right node)
                (incf (jbbt-data (jbbt-right node)))
                (setf (jbbt-right node)
                      (create-jbbt 1 nil nil)))
            (jbbt-grow (subseq str 1)
                       (jbbt-right node)))))))

(defun jbbt-climb (node out-vec &optional (test #'>))
  (let* ((zero (jbbt-left node))
         (one (jbbt-right node))
         (next-branch (cond ((or (null zero) (null one)) (or zero one))
                            ((funcall test (jbbt-data zero) (jbbt-data one)) zero)
                            (t one)))
         (bit (if (eq next-branch zero) 0 1)))
    (when next-branch
      (vector-push bit out-vec)
      (jbbt-climb next-branch out-vec test))))

(defun 3b (f)
  "Follow the most common character on the one side, least common at the other.
   I'm solving it by building a tree structure."
  (with-open-file (in f)
    (when in
      (let ((visit-tree (create-jbbt 0 nil nil)))
        (do* ((line (read-line in nil) (read-line in nil))
              (len (length line) len)
              (acc '() acc))

             ;; end condition and progn
             ((null line)
              (let ((o2-gen-acc (make-array (list len) :element-type 'bit :fill-pointer 0))
                    (co2-scrub-acc (make-array (list len) :element-type 'bit :fill-pointer 0)))
                (jbbt-climb visit-tree o2-gen-acc)
                (jbbt-climb visit-tree co2-scrub-acc #'<=)
                (flet ((bitvec->int (bv)
                         (reduce (lambda (acc bit) (+ bit (ash acc 1))) bv)))
                  (* (bitvec->int o2-gen-acc) (bitvec->int co2-scrub-acc)))))

          ;; loop-step
          (jbbt-grow line visit-tree))))))

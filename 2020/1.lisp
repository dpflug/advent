(defun day1-1 (f)
  (let ((in (open f :if-does-not-exist nil))
        (nums (make-hash-table)))
    (when in
      (loop for line = (read-line in nil)
            while line
            do (let* ((n (parse-integer line))
                                 (pair (- 2020 n))
                                 (pair-seen (gethash pair nums)))
                            (if pair-seen
                                (progn (print (list n pair))
                                       (print (* n pair))
                                       (return))
                                (setf (gethash n nums) 1)))))))

(defun day1-2 (f)
  (let ((in (open f :if-does-not-exist nil)))
    (when in
      (let* ((nums (loop for line = (read-line in nil)
                        while line
                         collect (parse-integer line)))
             (triplets (reduce #'cartesian-product (list nums nums nums))))
        (loop for triplet in triplets
              when (= 2020 (reduce #'+ triplet))
                do (print (reduce #'* triplet))
                   (return))))))

(defun cartesian-product (a b)
  (mapcan
   (lambda (item-from-a)
     (mapcar
      (lambda (item-from-b)
        (if (listp item-from-a)
            (append item-from-a (list item-from-b))
            (list item-from-a item-from-b)))
      b))
   a))

(day1-1 "1_sample.txt")
(day1-1 "1_input.txt")
(day1-2 "1_sample.txt")
(day1-2 "1_input.txt")

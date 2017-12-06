; Sum digits that match their trailing digit
; Last digit matches with first
(de sum-matching-next (s)
    (let (l (mapcar format (chop s)))
      (sum '((el next)
             (if (= el next)
                 el
               0))
           (copy l)
           (rot l))))

; Sum digits that match the digit halfway "around" the list from them
(de sum-half-around (s)
    (let (l (mapcar format (chop s)))
         (sum '((el half)
                (if (= el half)
                    el
                  0))
              (copy l)
              (do (/ (length l) 2)
                  (rot l)))))

; Why doesn't this work?
(de advent1 (s part1)
    (let (l (mapcar format (chop s)))
      (sum '((el match)
             (if (= el match)
                 el
               0))
           (copy l)
           (if part1
               (rot l)
             (do (/ (length l) 2)
                 (rot l))))))

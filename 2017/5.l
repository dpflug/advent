; Jumping around
(de advent5 ()
    (let (l (mapcar format
                    (mapcar pack
                            (split (in "5.txt" (till NIL))
                                   "^J")))
            cursor 1
            acc 0)
      (until (or (< cursor 1)
                 (> cursor (length l)))
             (inc 'acc)
             (setq cursor (+ cursor (swap (nth l cursor)
                                          (+ (get l cursor) 1)))))
      (prinl (- acc 1)))) ; The acc is off by one

(de advent5b ()
    (let (l (mapcar format
                    (mapcar pack
                            (split (in "5.txt" (till NIL))
                                   "^J")))
            cursor 1
            acc 0)
      (until (or (< cursor 1)
                 (> cursor (length l)))
             (inc 'acc)
             (let (loc (get l cursor)
                       adj (if (>= loc 3)
                               -1
                             1))
               (setq cursor (+ cursor (swap (nth l cursor)
                                            (+ loc adj))))))
      prinl (- acc 1)))

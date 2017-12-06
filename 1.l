(de sum-matching-next (s)
    (let (l (mapcar format (chop s)))
      (sum '((el next)
             (if (= el next)
                 el
               0))
           (format l)
           (reverse (cons (car l) (reverse (cdr l)))))))

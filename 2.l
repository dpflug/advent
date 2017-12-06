; Compute checksum for a block of numbers

; For each line subtract the highest number from the lowest
; Then sum the results
(de advent2 ()
    (let (acc 0)
      (in "2.txt"
          (until (eof)
                 (let (l (read-tsv-line (line)))
                   (inc 'acc (- (apply max l) (apply min l))))))
      (print acc)))

; For each line, subtract the two numbers that are evenly divisible
; Then sum the results
(de advent2b ()
    (let (acc 0)
      (in "2.txt"
          (until (eof)
                 (let (l (read-tsv-line (line))
                       matches (find-pair-divisible (sort l '>)))
                   (inc 'acc (apply / matches)))))
      (print acc)))

; Helper functions
; tab-delimited number strings -> list of numbers
(de read-tsv-line (s)
    (mapcar format (mapcar pack (split s "^I"))))

; Find a pair of numbers in a sorted list that divide evenly
(de find-pair-divisible (l)
    (let (f (car l)
            match (find '((n) (=0 (% f n)))
                        (cdr l)))
      (if match
          (list f match)
        (find-pair-divisible (cdr l)))))

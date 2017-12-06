; Make sure words aren't repeated on a line
(de advent4 ()
    (let (acc 0)
      (in "4.txt"
          (until (eof)
                 (let (l (mapcar pack (split (line) " ")))
                   (if (= (length l)
                          (length (uniq l)))
                       (inc 'acc)))))
      (prinl acc)))

; Make sure words can't create anagrams of each other on a line
(de advent4b ()
    (let (acc 0)
      (in "4.txt"
          (until (eof)
                 (let (l (mapcar pack (mapcar sort (split (line) " "))))
                   (if (= (length l)
                          (length (uniq l)))
                       (inc 'acc)))))
      (prinl acc)))

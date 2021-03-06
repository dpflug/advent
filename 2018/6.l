#!/usr/bin/pil
(def '*Counts ())

(de day6-1 (F)
    (in F (day6-1-helper (make (until (eof) (link (parse-line-d6))))))
    (maxi cdr *Counts))

(de parse-line-d6 ()
    (and (match '(@X "," " " @Y) (line))
         (list (format @X) (format @Y))))

(de day6-1-helper (Points)
    (let (Min-x (car (mini car Points))
          Max-x (car (maxi car Points))
          Min-y (cadr (mini cadr Points))
          Max-y (cadr (maxi cadr Points)))
      (for (X Min-x (>= Max-x X) (inc X))
           (for (Y Min-y (>= Max-y Y) (inc Y))
                (let (M '((P) (+ (abs (- (car P) X)) (abs (- (cadr P) Y))))
                      Dist-close (M (mini M Points))
                      Closest (filter '((@P) (= (M @P) Dist-close)) Points))
                  (unless (or (< 1 (length Closest))
                           (member (caar Closest) (list Min-x Max-x))
                           (member (cadar Closest) (list Min-y Max-y)))
                    (accu '*Counts (car Closest) 1)))))))

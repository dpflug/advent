#!/usr/bin/guile \
-e main -s
!#
;;; coding: utf-8
(use-modules (ice-9 rdelim)
             (ice-9 binary-ports)
             (srfi srfi-1))

(define limits
    '((red . 12)
      (green . 13)
      (blue . 14)))

(define subset-possible?
    ;; (number color number color) -> bool
    (case-lambda
     (() #t)
     ((n color . rest)
      (let ((v (assq-ref limits color)))
          (and v
               (<= n v)
               (apply subset-possible? rest))))))

(define parse-reveals
    ;; ("" "5" "green" "" "3" "red") -> (5 green 3 red)
    (case-lambda
     (() '())
     ((ignore ns cs . rest)
      (let ((n (string->number ns))
            (color (string->symbol cs)))
          (cons* n color (apply parse-reveals rest))))))

(define (parse-subset s)
    ;; " 5 green, 3 red" -> (5 green 3 red)
    (let ((reveals (string-split s (string->char-set ", "))))
        (apply parse-reveals reveals)))

(define (calc-line l)
    (let* ((game (string-split l #\:))
           (label (string-split (car game) #\Space))
           (gn (string->number (cadr label)))
           (subset-strings (string-split (cadr game) #\;))
           (subsets (map parse-subset subset-strings)))
        (if (fold (lambda (subset prev)
                      (and prev
                           (apply subset-possible? subset)))
                  #t
                  subsets)
            gn 0)))

(define (do-calc)
    (do ((l (read-line) (read-line))
         (sum 0 (+ sum (calc-line l))))
        ((eof-object? l) sum)))

(define (main args)
    (write-line (do-calc)))

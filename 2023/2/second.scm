#!/usr/bin/guile \
-e main -s
!#
;;; coding: utf-8
(use-modules (ice-9 rdelim)
             (ice-9 binary-ports)
             (srfi srfi-1))

(load "first.scm")

(define (min-possible-count cur prev)
    ;; (5 green 3 red) '() -> ((green . 5) (red . 3))
    ;; (1 green 6 red) ((green . 5) (red . 3)) -> ((green . 5) (red . 6))
    (if (null? cur)
        prev
        (let* ((n (car cur))
               (color (cadr cur))
               (v (assq-ref prev color)))
            (min-possible-count (cddr cur)
                                (assq-set! prev color (max n (or v 0)))))))

(define (calc-line l)
    (let* ((game (string-split l #\:))
           (label (string-split (car game) #\Space))
           (gn (string->number (cadr label)))
           (subset-strings (string-split (cadr game) #\;))
           (subsets (map parse-subset subset-strings))
           (min-count (fold min-possible-count '() subsets)))
        (fold (lambda (cur prev)
                  (* prev (cdr cur)))
              1
              min-count)))

(define (do-calc)
  (do ((l (read-line) (read-line))
       (sum 0 (+ sum (calc-line l))))
      ((eof-object? l) sum)))

(define (main args)
  (write-line (do-calc)))

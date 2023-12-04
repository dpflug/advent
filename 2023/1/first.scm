#!/usr/bin/guile \
-e main -s
!#
;;; coding: utf-8
(use-modules (ice-9 rdelim)
             (ice-9 binary-ports))

(define (find-number s)
    (let* ((lin (string-skip s char-set:letter))
           (rin (string-skip-right s char-set:letter))
           (str (string (string-ref s lin)
                        (string-ref s rin))))
        (string->number str)))


(define (do-calc)
    (do ((l (read-line) (read-line))
         (sum 0 (+ (find-number l) sum)))
        ((eof-object? l) sum)))

(define (main args)
    (write-line (do-calc)))

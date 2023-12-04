#!/usr/bin/guile \
-e main -s
!#
;;; coding: utf-8
(use-modules (ice-9 string-fun)
             (ice-9 binary-ports))

(load "first.scm")

(define (digitize-me s)
    ;; If I blindly replace with digits, later matches might fail: "oneight"
    ;; so add any additional letters other number strings might have
    (let* ((s1 (string-replace-substring s "one" "o1e"))
           (s2 (string-replace-substring s1 "two" "t2o"))
           (s3 (string-replace-substring s2 "three" "t3e"))
           (s4 (string-replace-substring s3 "four" "4"))
           (s5 (string-replace-substring s4 "five" "5e"))
           (s6 (string-replace-substring s5 "six" "6"))
           (s7 (string-replace-substring s6 "seven" "7n"))
           (s8 (string-replace-substring s7 "eight" "e8t"))
           (s9 (string-replace-substring s8 "nine" "n9e")))
        s9))

(define (parse-line l)
    (find-number (digitize-me l)))

(define (do-calc-2)
    (do ((l (read-line) (read-line))
         (sum 0 (+ (parse-line l) sum)))
        ((eof-object? l) sum)))

(define (main args)
    (write-line (do-calc-2)))

;;  Advent of Code 2022
;;

(define (day1-1 elf-counts)
  (let ((count-list (string-split elf-counts #\Newline)))
    (let reduce ((to-count count-list) (max-elf 0) (current-elf 0))
      (if (null? to-count)
          (max max-elf current-elf)
          (let* ((current-count (car to-count))
                 (parsed (string->number current-count)))
            (cond ((= 0 (string-length current-count))
                   (reduce (cdr to-count) (max current-elf max-elf) 0))
                  (parsed (reduce (cdr to-count) max-elf (+ current-elf parsed)))
                  (#t (error (string-append "Unable to parse number: " current-count)))))))))

(define (day1-2 elf-counts)
  (let ((count-list (string-split elf-counts #\Newline)))
    (let reduce ((to-count count-list) (elves '()) (current-elf 0))
      (if (null? to-count)
          (let* ((srtd (sort (cons current-elf elves) >=)))
            (apply + (list (car srtd) (list-ref srtd 1) (list-ref srtd 2))))
          (let* ((current-count (car to-count))
                 (parsed (string->number current-count)))
            (cond ((= 0 (string-length current-count))
                   (reduce (cdr to-count) (cons current-elf elves) 0))
                  (parsed (reduce (cdr to-count) elves (+ current-elf parsed)))
                  (#t (error (string-append "Unable to parse number: " current-count)))))))))

(define (day2-1 input)
  (define (parse-turn str)
    (list (string-ref str 0) (string-ref str 2)))
  (define (move->value char)
    ;;  A & X = 1, B & Y = 2, C & Z = 3
    (- (modulo (char->integer char) 23) 18))
  (define (outcome turn)
    ;;  0 on loss, 3 on draw, 6 on win
    (list-ref '(0 6 3 0 6)
              (+ 2 (- (car turn) (cadr turn)))))
  (define (sum-score to-count sum)
    (if (null? to-count)
        sum
        (let* ((this-turn-strings (car to-count))
               (this-turn (map move->value this-turn-strings))
               (my-move (cadr this-turn))
               (this-outcome (outcome this-turn)))
          (sum-score (cdr to-count) (+ sum my-move this-outcome)))))
  (let* ((turns (string-split input #\Newline))
         (movelist (map parse-turn turns)))
    (sum-score movelist 0)))

(define (day2-2 input)
  (define (parse-turn str)
    (list (string-ref str 0) (string-ref str 2)))
  (define (move->value char)
    (- (modulo (char->integer char) 23) 18))
  (define (outcome turn)
    ;;  0 on loss, 3 on draw, 6 on win
    (list-ref '(0 6 3 0 6)
              (+ 2 (- (car turn) (cadr turn)))))
  (define (pick-move turn)
    (1+ (modulo (+ (car turn) (- (1- (cadr turn)) 2)) 3)))
  (define (sum-score to-count sum)
    (if (null? to-count)
        sum
        (let* ((this-turn-strings (car to-count))
               (this-turn (map move->value this-turn-strings))
               (my-move (pick-move this-turn))
               (this-outcome (outcome (list (car this-turn) my-move))))
          (sum-score (cdr to-count) (+ sum my-move this-outcome)))))
  (let* ((turns (string-split input #\Newline))
         (movelist (map parse-turn turns)))
    (sum-score movelist 0)))

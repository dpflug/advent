#!/usr/bin/pil
(de day3-1 (F)
    (in F (let (Swatches (make (until (eof) (link (parse-line-d3))))
                Cloth (make (do 1000 (link (need 1000)))))
            (for Swatch Swatches
              (let (X1 (caadr Swatch)
                    Y1 (cadadr Swatch)
                    X2 (+ (X1 (cadr (caddr Swatch))))
                    Y2 (+ (Y1 (cadr (caddr Swatch)))))))))
    (() ()))

(de parse-line-d3 ()
    (and (match '("#" @Id (chop " @ ") @X-edge "," @Y-edge ":" " " @Width "x" @Height) (line))
         (list @Id '(@X-edge @Y-edge) '(@Width @Height))))

(de day3-2 (F)
    (() ()))

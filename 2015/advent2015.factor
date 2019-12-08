! Copyright (C) 2018 David Pflug
! See http://factorcode.org/license.txt for BSD license.
USING: io.encodings.utf8 io.files kernel math math.parser prettyprint sequences
sequences.deep sorting splitting unicode ;
IN: advent2015

: parse-day2 ( seq -- seq' ) [ "x" split ] map [ [ string>number ] map ] map ;

: wrap-ribbon ( seq -- seq' )
    [ natural-sort dup length 1 - swap remove-nth ] map
    flatten [ 2 * ] map ;

: calc-day2 ( packages -- n )
    [ [ 1 [ * ] reduce ] map ]
    [ wrap-ribbon ]
    bi
    append 0 [ + ] reduce ;

: day2-2 ( filepath -- ) utf8 file-lines parse-day2 calc-day2 . ;

! ------ !
! Day 4  !
! ------ !

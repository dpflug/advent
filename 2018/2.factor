! Copyright (C) 2018 David Pflug.
USING: io io.encodings.utf8 io.files lcs kernel math math.combinatorics math.statistics sequences ;
IN: advent2018

: dup-letters? ( string -- ? ) sorted-histogram [ second 2 = ] any? ; inline

: tri-letters? ( string -- ? ) sorted-histogram [ second 3 = ] any? ; inline

: num-dups ( lines -- n ) [ dup-letters? ] filter length ; inline
: num-tris ( lines -- n ) [ tri-letters? ] filter length ; inline

: day2-1 ( filepath -- n ) utf8 file-lines [ num-dups ] [ num-tris ] bi * ; inline

: find-close-strings ( seq -- seq' ) 2 [ [ first ] [ second ] bi levenshtein 1 = ] find-combination ; inline

: day2-2 ( filepath -- str ) utf8 file-lines find-close-strings first2 lcs ;

"2_sample.txt" day2-1
"2_sample.txt" day2-2
"2_data.txt" day2-1
"2_data.txt" day2-2

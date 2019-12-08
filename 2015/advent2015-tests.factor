! Copyright (C) 2018 David Pflug.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test advent2015 ;
IN: advent2015.tests

{ { { 2 3 4 } } } [ { "2x3x4" } parse-day2 ] unit-test
{ { { 1 1 10 } } } [ { "1x1x10" } parse-day2 ] unit-test
{ { 4 6 } } [ { { 2 3 4 } } wrap-ribbon ] unit-test
{ { 2 2 } } [ { { 1 1 10 } } wrap-ribbon ] unit-test
{ 34 } [ { { 2 3 4 } } calc-day2 ] unit-test
{ 14 } [ { { 1 1 10 } } calc-day2 ] unit-test
{ 48 } [ { { 1 1 10 } { 2 3 4 } } calc-day2 ] unit-test

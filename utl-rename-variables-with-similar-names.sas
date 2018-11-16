Rename variables with similar names

github
https://tinyurl.com/y7po275l
https://github.com/rogerjdeangelis/utl-rename-variables-with-similar-names

SAS Forum
https://tinyurl.com/ydb3ekty
https://communities.sas.com/t5/SAS-Programming/Rename-many-variables-with-similar-names/m-p/514041

varlist macro by
Author: Søren Lassen, s.lassen@post.tele.dk

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


INPUT
=====

HAVE total obs=3

 REC FACE201701 FACE201702 FACE201703 BUCKET201701 BUCKET201702 BUCKET201703

  1    1            2          2            4            5            6
  2    1            2          2            4            5            6
  3    1            2          2            4            5             6

RULES
-----

  Rename variable BUCKET201801 to SERVICE01701.
  Rename variable BUCKET201802 to SERVICE01702.
  Rename variable BUCKET201803 to SERVICE01703.

  Rename variable FACE201701 to AMT01701.
  Rename variable FACE201702 to AMT01702.
  Rename variable FACE201703 to AMT01703.


EXAMPLE OUTPUT
--------------


HAVE total obs=3

  REC    AMT01701    AMT01702    AMT01703    SERVICE01701    SERVICE01702    SERVICE01703

   1         1           2           2             4               5               6
   2         1           2           2             4               5               6
   3         1           2           2             4               5               6


PROCESS
=======

%array(faces,values=%varlist(have,prx=/^face/i),Qstyle=double,od=%str(,));
%array(buckets,values=%varlist(have,prx=/^bucket/i));

proc datasets;

  modify have;
  rename
    %do_over(faces buckets, phrase=%str(
        ?faces   = amt%nrstr(%substr(?faces,6)))
        ?buckets = service%nrstr(%substr(?faces,6))
    );
run;quit;

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;

  retain rec
     face201701 1 face201702 2 face201703 2
     bucket201801 4 bucket201802 5 bucket201803 6
  ;

  do rec=1 to 3;
     output;
  end;

run;quit;



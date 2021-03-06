#!/bin/bash

# For now, for markdown, just wrap everything in a "pre" tag
echo "<pre>"

# Date and URL should be here, e.g.
# Fetched 22May2019 from https://travis-ci.com/StanfordAHA/garnet/builds/112832399
egrep ^Fetched $1

##############################################################################
# This grabs all the relevant info in sections
# "test session starts", "warnings summary"

# Initial cleanup; insert newlines, extract only relevant bits
# </a> means end of line??
sed 's/<\/a>/<\/a>\n/g' $1 \
  | sed 's/<[^>]*>//g' \
  | sed -n '/test session starts/,/Your build exited/'p \
  > /tmp/ptcleanup1.$$

# Extract the summary and put it on top
egrep 'passed.*skipped.*warnings' /tmp/ptcleanup1.$$
echo ""

# Don't want detailed FAILURE info
cat /tmp/ptcleanup1.$$ \
  | awk '
BEGIN          { noprint = 0}
/= FAILURES =/ { noprint = 1}
/= warnings /  { noprint = 0}
noprint == 0   { print      }
' > /tmp/ptcleanup2.$$

# exit

# sed 's/^tests.test_//'
#   tests/test_garnet/test_garnet.py PASSED... =>
#   garnet/test_garnet.py PASSED...
# 
# sed 's|^[^/]*/test_||' \
#   garnet/test_garnet.py PASSED... =>
#   garnet.py PASSED... =>



#   | sed 's/^tests.test_//' \
#   | sed 's|^[^/]*/test_||' \



# Pretty it up and print it
cat /tmp/ptcleanup2.$$ \
  | egrep -v '^(platform|cachedir|rootdir|plugins|collecting)' \
  | sed 's/^tests.test_//' \
  | awk '
    # /%]$/ { print "FOO " $0 }
    /%]$/ { printf("%-50s     %-8s %-8s\n", substr($1,1,50), $2, substr($0, length($0)-5, 6)); next }
    { print }
  '

/bin/rm /tmp/*.$$

# For now, for markdown, just wrap everything in a "pre" tag
echo "<pre>"



exit





# Remove tags
sed 's/<[^>]*>//g' $1 \
  | sed 's/tests/\ntests/g' \
  | sed 's/\([^=]\)===/\1\n===/' \
  | egrep '^tests|==='



exit



sed 's/>/>\n/g' $1 \
  | sed -n '/test session starts/,$p' \
  | sed 's/<[^>]*>//g' \
  | sed '/%]$/d' \
  | grep . \
  | awk '\
1==0 { print "\n" found_test " FOO " $0 } \
/^tests/ { found_test = 1; t=$0; next } \
found_test==0 { print } \
found_test==1 { printf("%s%s\n", t, $0); found_test = 0 }\
  '\
  | grep .


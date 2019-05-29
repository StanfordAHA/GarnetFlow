#!/bin/bash
DBG=1

########################################################################
# Name of test repo e.g. "garnet":
# "Fetched https://travis-ci.com/StanfordAHA/garnet/builds/113359834 28-May-2019"

repo_name=`head $1 | grep Fetch | sed '/Fetch/{s|.*/\(.*\)/build.*|\1|}'`


########################################################################
# Want something that looks like this maybe:
# in: "===== 43 passed, 1 skipped, 12 warnings in 344.27 seconds ======"
# out:
#   #### garnet
#   NO FAILS - 43 passed, 1 skipped, 12 warnings

fail=`echo $sum | sed 's/.* \([0-9]* fail\).*/\1/'`
echo "$fail" | (grep fail >& /dev/null) && fail="FAILS!!!" || fail="NO FAILS"
# echo "  $fail" | awk '{ printf("%3s %s\n", $1, $2)}'
# echo "## $repo_name hw test summary (click links for more info)"
echo "## $repo_name"

sum=`
  awk '/fail|pass|skip|warn/ { print $0; exit; }' $1 \
  | sed 's/=//g' | sed 's/ in.*//g' | sed 's/^ *//'
`
# test $DBG -gt 0 && echo "$sum"


tlog=`head $1 | grep Fetch | awk '{print $2}'`

echo -n "$fail - $sum - "
echo -n "[complete travis log]($tlog)"
echo "<br/>"


# pass=`echo $sum | sed 's/.* \([0-9]* passed\).*/\1/'`
# echo "$pass" | (grep pass >& /dev/null) || pass="0 passed"
# echo "  $pass" | awk '{ printf("%3s %s\n", $1, $2)}'
# 
# skip=`echo $sum | sed 's/.* \([0-9]* skip\).*/\1/'`
# echo "$skip" | (grep skip >& /dev/null) || skip="0 skip"
# echo "  $skip" | awk '{ printf("%3s %s\n", $1, $2)}'
# 
# warn=`echo $sum | sed 's/.* \([0-9]* warn\).*/\1/'`
# echo "$warn" | (grep warn >& /dev/null) || warn="0 warn"
# echo "  $warn" | awk '{ printf("%3s %s\n", $1, $2)}'

# echo "<pre>"
# echo "</pre>"

########################################################################
# Want something that looks like this maybe:
# IN:
#   garnet/test_garnet.py                                  PASSED   [  6%]  
#   garnet/test_garnet.py::test_garnet                     PASSED   [  9%]  
#   global_buffer/test_cfg_controller_verilator_sim.py     PASSED   [ 11%]  
#   global_buffer/test_cfg_controller_verilator_sim.py     PASSED   [ 13%]  
#   global_buffer/test_global_buffer_int_verilator_sim     PASSED   [ 15%]  
# OUT:
#   garnet (2 tests) https://github.com/StanfordAHA/garnet/tree/master/tests/test_garnet
#   global_buffer (5 tests) https://github.com/StanfordAHA/garnet/tree/master/tests/test_global_buffer

########################################################################
# hah but of course lassen is different
# IN: 
#   complex.py::test_fma[args12]                           PASSED   [  2%]  
#   complex.py::test_fma[args13]                           PASSED   [  2%]  
#   lut.py::test_lut_binary[op0]                           PASSED   [  3%]  
#   lut.py::test_lut_binary[op1]                           PASSED   [  3%]  
#   lut.py::test_lut_binary[op2]                           PASSED   [  3%]  


# grep PASSED $1 | head -1 | grep -q / && sep='/' || sep=':'
sep='/'

f=$1
repo="${f%.*}"

if [[ "$repo" == "lassen" ]]; then
  # Collapse     "lut.py::test_lut_unary[op0]" => lut.py::test_lut_unary
  # mapper only: "mapper.py::test_io"          => mapper.py
  sed -n '/test session starts/,/===\|overage/'p $f\
    | awk '
      ! /::/ { next; }
      $1 == "lut.py::test_lut" { print $1; next; }
      /mapper/   { gsub(/::.*/, "", $1) ; print $1 }
      ! /mapper/ { gsub(/\[.*/, "", $1)  ; print $1 }
    '\
    | uniq -c \
    | awk '
      { ntests = $1 }
      { t=sprintf("[%s (%d test%s)](", $2, ntests, ntests==1?"":"s") }
      { gsub(/::.*/, "", $2) }
      { URL = "https://github.com/StanfordAHA/'$repo'/tree/master/tests/test_" $2 }
      { printf("%-45s%s)<br/>\n", t, URL) }
    '

elif [[ "$repo" == "garnet" ]]; then
  sed -n '/test session starts/,/===\|overage/'p $f\
    | sed 's|::|/|g'\
    | awk -F $sep   '/['$sep']/ {print $1}'\
    | uniq -c \
    | awk '
      { ntests = $1; if ("'$repo'" == "garnet") ntests = ntests - 1; }
      { t=sprintf("[%s (%d test%s)](", $2, ntests, ntests==1?"":"s") }
      { URL = "https://github.com/StanfordAHA/'$repo'/tree/master/tests/test_" $2 }
      { printf("%-32s%s)<br/>\n", t, URL) }
  '
fi

# tests/test_lut.py::test_lut_unary[op0] PASSED                            [  3%]
# tests/test_lut.py::test_lut_ternary[op0] PASSED                          [  3%]
# tests/test_lut.py::test_lut PASSED                                       [  4%]
# tests/test_mapper.py::test_discover SKIPPED                              [  4%]
# tests/test_mapper.py::test_const PASSED                                  [  4%]
# tests/test_mapper.py::test_io PASSED                                     [  4%]
# tests/test_mapper.py::test_float PASSED                                  [  4%]
# tests/test_mapper.py::test_fp_pointwise PASSED                           [  5%]
# tests/test_mapper.py::test_serialize PASSED                              [  5%]
# tests/test_mapper.py::test_rules PASSED                                  [  5%]
# tests/test_mapper.py::test_binary_lut[and] PASSED                        [  5%]
# tests/test_mapper.py::test_binary_lut[or] PASSED                         [  5%]
# tests/test_mapper.py::test_binary_lut[xor] PASSED                        [  6%]
# tests/test_mapper.py::test_init PASSED                                   [  6%]
# tests/test_pe.py::test_unsigned_binary[args0-op0] PASSED                 [  6%]
# tests/test_pe.py::test_unsigned_binary[args0-op1] PASSED                 [  6%]




#   sed -n '/test session starts/,/===\|overage/'p $f\
#     | sed 's|::|/|g'\
#     | awk -F $sep   '/['$sep']/ {print $1}'\
#     | uniq -c \
#     | awk '
#       { ntests = $1; if ("'$repo'" == "garnet") ntests = ntests - 1; }
#       { t=sprintf("[%s (%d test%s)](", $2, ntests, ntests==1?"":"s") }
#       { URL = "https://github.com/StanfordAHA/'$repo'/tree/master/tests/test_" $2 }
#       { printf("%-32s%s)<br/>\n", t, URL) }
#   '







# pass=`\
#   awk '/fail|pass|skip|warn/ { print $0; exit; }' \
#   | sed 's/.* \([0-9]* passed\).*/\1/'\
# `




# echo $fail

# if test "$s" != "$t"; then echo foo; fi
# test=`expr $domain : stanford`; if [ $test -eq 8 ]; then stanford=1; fi
# if `test "$answer" = 'n' -o "$answer" = 'N'`; then return 255; fi
# [[ $REPLY =~ ^[Yy]$ ]] || echo "Okay bye"
# [[ $REPLY =~ ^[Yy]$ ]] || exit
# if [[ "$ent" == "" ]]; then continue; fi
# if [[ "$ent" == "" ]]; then
# test $mydir = "$0/" && mydir=./



# 
# 
# 
#   awk '/fail|pass|skip|warn/ { print $0; exit; }' \
#   | sed 's/.* \([0-9]* failures\).*/\1/'\
# `
# echo $fail
# 
# 
# 
# # 
# # 
# # 
# # 
# # /test session starts/,/(===|coverage)/
# # config_reg.py - 2 tests - PASS
# 
# 
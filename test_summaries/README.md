Latest test summary is here: [summary.md](summary.md)

So far it includes information from Lassen and Garnet, 
drawn from the following travis logs (latest master branch):
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;
[garnet](https://travis-ci.com/StanfordAHA/garnet/branches) (master)
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;
[lassen](https://travis-ci.com/StanfordAHA/lassen/branches) (lassen)

<b>Power domain</b> test is represented by this line in the garnet log:<br/>
`tests/test_interconnect/test_interconnect_cgra.py::test_interconnect_point_wise[True-100] PASSED [ 36%]`
<br/>
The "True" in square brackets means "test with power domains added". Also see
<br/>
https://github.com/StanfordAHA/garnet/blob/master/tests/test_interconnect/test_interconnect_cgra.py

Not included (yet) are <b>SoC</b> tests. 
We have not yet identified a source for those.

<i><b>NOTE</b> lassen tests should probably be coming from buildkit
and not travis (right?).</i>

<b>Generating the summary manually</b><br/>
Test summaries are built via the following command sequence 
(usually I do this from kiwi):
<pre>
  % make summary
  % git diff summary.md
  % git add summary.md
  % git commit -m 'test summary update'
  % git push
</pre>

For the build to succeed, you must have "geckodriver installed and in
your path.On kiwi it is in /usr/local/lib.

<b>Generating the summary automatically</b><br/>
Soon I hope to have a once-pre-hour cron job that will update
summary.md automatically.

<b>Notes</b><br/>
For more information see `0notes.txt`







Latest test summary is in [summary.md](summary.md)

So far it includes information from Lassen and Garnet, 
drawn from the following travis logs (latest master branch):
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;
[garnet](https://travis-ci.com/StanfordAHA/garnet/branches) (master)
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;
[lassen](https://travis-ci.com/StanfordAHA/lassen/branches) (lassen)

Not included (yet) are <b>power domain</b> and <b>SoC</b> tests. 
We have not yet identified a source for those.

#### Generating the summary manually

Test summaries are build via the following command sequence 
(usually I do this from kiwi):
<pre>
  % make summary
  % git add summary.md
  % git commit -m 'test summary update'
  % git push
</pre>

For the build to succeed, you must have "geckodriver installed and in
your path.On kiwi it is in /usr/local/lib.

#### Generating the summary automatically

Soon I hope to have a once-pre-hour cron job that will update
summary.md automatically.

#### Notes

For more information see `0notes.txt`







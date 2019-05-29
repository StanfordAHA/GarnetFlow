Latest test summary is in [summary.md](summary.md)

So far it includes information from Lassen and Garnet, drawn from the following travis logs:
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;
[garnet](https://travis-ci.com/StanfordAHA/garnet/branches) (master)
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;
[memory](https://travis-ci.com/StanfordAHA/garnet/branches) (memory_db)

Not included (yet) are '''power domain''' and '''SoC''' tests. We have not yet identified a source for those.

#### Generating the summary

Test summaries are build via the following command sequence (usually I do this from kiwi):
  % make summary.md
  % git add summary.md
  % git commit -m 'test summary update'
  % git push

For the build to succeed, you must have "geckodriver installed and in your path.On kiwi it is in /usr/local/lib.

Soon I hope to have a once-pre-hour cron job that will update summary.md automatically.

#### Notes

For more information see `0notes.txt`







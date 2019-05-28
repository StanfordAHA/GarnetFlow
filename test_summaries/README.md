Test summaries:
* [garnet\[*\]](garnet.md)
* [lassen](lassen.md)

<small><i>
&nbsp;&nbsp;&nbsp;&nbsp; [*] Note Garnet test includes memory et al.
</i></small>

Still need: soc, power domain tests.

To build test summaries:
  alias fb=bin/fetch_travis_build_history.py; alias bns=bin/build_nice_summary.sh
  fb -v StanfordAHA/garnet master -o tmpfile; bns tmpfile > garnet.md
  fb -v StanfordAHA/lassen master -o tmpfile; bns tmpfile > lassen.md


Make sure "geckodriver" is in your path. On kiwi it is in /usr/local/lib

#### TODO
- better summary for lassen
- lassen should probably come from buildkite instead of travis
- still need pd, soc
- cron job for test updates
- checkmarks (above) for pass/fail



#### Sources
[garnet](https://travis-ci.com/StanfordAHA/garnet/branches) (master)
[memory](https://travis-ci.com/StanfordAHA/garnet/branches) (memory_db)



#### NOTES
These work so far (v0):
  alias fb=bin/fetch_travis_build_history.py; alias bns=bin/build_nice_summary.sh
  fb StanfordAHA/garnet master -o tmpfile; bns tmpfile > garnet.md
  fb StanfordAHA/lassen master -o tmpfile; bns tmpfile > lassen.md
  fb StanfordAHA/garnet memory_core_db -o tmpfile; bns tmpfile > memory.md WOOHOO!

Not working yet: soc, pd


#### DONE

DONE 1905
- move to github
- eliminate geckodriver log, see bin/geckodriver --help
- consolidate 0notes etc
- include URL,date in garnet_summary, something like:
  "Latest travis log <url>, dated <date>"
- garnet v0
- lassen v0
- memory v0
- move tests to new location...
- update garnet.md to latest, should now include memory tests
- delete memory.md in favor of garnet.md
- mem: garnet memory_core_db branch


</pre>









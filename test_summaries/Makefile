FB = bin/fetch_travis_build_history.py
BNS= bin/build_nice_summary.sh
SUM=bin/summarize.bash

summary.md: garnet.md lassen.md
	$(SUM) garnet.md > summary.md
	$(SUM) lassen.md > summary.md


lassen:
	$(FB) -v StanfordAHA/lassen master -o tmpfile
	$(BNS) tmpfile > lassen.md


garnet:
	$(FB) -v StanfordAHA/garnet master -o tmpfile
	$(BNS) tmpfile > garnet.md

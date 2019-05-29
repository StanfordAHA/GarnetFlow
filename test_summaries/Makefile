# Shell scripts
FB  := bin/fetch_travis_build_history.py
BNS := bin/build_nice_summary.sh
SUM := bin/summarize.bash

# Without the colon it re-evaluates on every instance of "${PID)" (!)
PID  := $(shell echo $$$$)
DATE := $(shell date +%y%m%d)

summary:
	mv summary.md summary.old.$(DATE).$(PID)
	make lassen
	make garnet
	$(SUM) lassen.md >> summary.md
	echo ""          >> summary.md
	$(SUM) garnet.md >> summary.md
	diff summary.old.$(DATE).$(PID) summary.md && echo 'no change'


lassen:
	$(FB) -v StanfordAHA/lassen master -o tmpfile
	$(BNS) tmpfile > lassen.md


garnet:
	$(FB) -v StanfordAHA/garnet master -o tmpfile
	$(BNS) tmpfile > garnet.md

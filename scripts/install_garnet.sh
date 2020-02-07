
# pin pycoreir version since the latest one doesn't work
pip3 install --ignore-installed coreir==2.0.19

# install this last since we already have a coreir built
python3 python_repo.py

# install genesis2
pip3 install genesis2

# clone garnet
if [[ -z $garnet ]]; then
    #git clone --depth 1 https://github.com/StanfordAHA/garnet
    git clone https://github.com/StanfordAHA/garnet
    cd garnet && git checkout revert-423-revert-420-lassen-cleanup
    cd ..
else
    git clone https://github.com/StanfordAHA/garnet
    cd garnet && git checkout $garnet
    cd ..
fi


#revert-423-revert-420-lassen-cleanup

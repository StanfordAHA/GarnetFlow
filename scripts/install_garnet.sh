pip3 install --ignore-installed coreir

# install this last since we already have a coreir built
python3 python_repo.py

# install genesis2
pip3 install genesis2

# clone garnet
if [[ -z $garnet ]]; then
    git clone --depth 1 https://github.com/StanfordAHA/garnet
else
    git clone https://github.com/StanfordAHA/garnet
    cd garnet && git checkout $garnet
    cd ..
fi

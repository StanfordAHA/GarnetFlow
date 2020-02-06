
# pin pycoreir version since the latest one doesn't work
pip3 install --ignore-installed coreir==2.0.19

# install this last since we already have a coreir built
python3 python_repo.py

# install genesis2
pip3 install genesis2

# clone garnet
if [[ -z $garnet ]]; then
    git clone https://github.com/StanfordAHA/garnet
    cd garnet
    git checkout 1980f795e22354addf3bc4e53ba8f555a1d6743c
    cd ..
else
    git clone https://github.com/StanfordAHA/garnet
    cd garnet && git checkout $garnet
    git checkout 1980f795e22354addf3bc4e53ba8f555a1d6743c
    cd ..
fi

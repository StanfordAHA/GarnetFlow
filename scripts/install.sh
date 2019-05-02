#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt
pip install -r ${REQUIREMENTS}


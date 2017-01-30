#!/bin/bash
source $HOME/build/py2venv/cloud/bin/activate
s3cmd -P sync artifacts s3://yum-repo-ryanbreed --delete-removed

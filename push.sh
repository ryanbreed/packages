#!/bin/bash
source $HOME/build/py2venv/cloud/bin/activate
createrepo artifacts/7
s3cmd -P sync artifacts s3://yum-repo-ryanbreed --delete-removed

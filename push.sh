#!/bin/bash
venv cloud
createrepo artifacts/7
s3cmd -P sync artifacts s3://yum-repo-ryanbreed --delete-removed

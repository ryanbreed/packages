#!/bin/bash
source "$( dirname $0 )/build_vars.sh"
source "$( dirname $0 )/build_funcs.sh"

make_dirs

for def in $*; do
  echo "building $def"
  source $def
  echo "DEFINED PACKAGE $PACKAGE"
  echo "download"
  download
  echo "build_install"
  build_install
  echo "packaging $PACKAGE"
  package
done

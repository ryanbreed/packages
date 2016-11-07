#!/bin/bash
export ROOT_BUILD="/var/tmp/build"
export ROOT_INSTALL="/var/tmp/build/rootfs"
export ROOT_COMPILE="/var/tmp/build/compile"
export DOWNLOAD="/var/tmp/build/cache"

export PKG_HOME="$PWD"
export ARTIFACTS="$PKG_HOME/artifacts"
export MANIFESTS="$PKG_HOME/mf"

function make_dirs {
  echo "making build environment"
  test -d $ROOT_BUILD || mkdir -v -p $ROOT_BUILD
  test -d $ROOT_INSTALL || mkdir -v -p $ROOT_INSTALL
  test -d $ROOT_COMPILE || mkdir -v -p $ROOT_COMPILE
  test -d $DOWNLOAD || mkdir -v -p $DOWNLOAD
}

function compile {
  echo "REDEFINE compile: $*"
}

function download {
  echo "REDEFINE download: $*"
}

function configure {
  echo "REDEFINE configure: $*"
}

function install_root {
  echo "REDEFINE install_root: $*"
}

function dependencies {
  echo "REDEFINE dependencies: $*"
}

function build_install {
  dependencies
  configure
  compile
  install_root
  build_package_manifest
}

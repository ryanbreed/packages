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
  test -d $ARTIFACTS ||mkdir -v -p $ARTIFACTS/7/{x86_64,noarch}
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

function display_setup {
  cat<<END
ROOT_BUILD=$ROOT_BUILD
ROOT_INSTALL=$ROOT_INSTALL
ROOT_COMPILE=$ROOT_COMPILE
DOWNLOAD=$DOWNLOAD
PKG_HOME=$PKG_HOME
ARTIFACTS=$ARTIFACTS
MANIFESTS=$MANIFESTS
PACKAGE=$PACKAGE
PACKAGE_VERSION=$PACKAGE_VERSION
PACKAGE_ITERATION=$PACKAGE_ITERATION
MAKEFLAGS=$MAKEFLAGS
d_url=$d_url
d_archive=$d_archive

CC=$CC
CPP=$CPP
CFLAGS=$CFLAGS
LDFLAGS=$LDFLAGS
CPPFLAGS=$CPPFLAGS
MAKEFLAGS=$MAKEFLAGS


END
}


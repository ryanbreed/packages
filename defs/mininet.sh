if [[ -z "${PKG_HOME}" ]]; then
  source "build_vars.sh"
fi

export PACKAGE="mininet"
export PACKAGE_VERSION="2.2.2b2"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export git_url="https://github.com/mininet/mininet.git"
export git_branch="tags/2.2.2b2"
export PREFIX=opt/${PACKAGE}

export CC=clang

function download {
  download_git "$git_url" "$git_branch"
}

function dependencies {
  install_buildtime_dependencies openvswitch
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  exit 0
}

function install_root {
  echo "INSTALL $PACKAGE"
  go_compile
  ./util/install.sh -s $(target_install)/${PREFIX} -a
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir \
    --provides mininet
}

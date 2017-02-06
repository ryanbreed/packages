if [[ -z "${PKG_HOME}" ]]; then
  source "build_vars.sh"
fi

export PACKAGE="strace"
export PACKAGE_VERSION="4.15"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export git_url="https://github.com/strace/strace.git"
export git_branch="tags/v4.15"

export CC=clang

function download {
  download_git "$git_url" "$git_branch"
}

function dependencies {
  install_buildtime_dependencies kernel-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./bootstrap
  ./configure \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --program-suffix=415 \
     --prefix=/usr 
  exit 0
}

function install_root {
  echo "INSTALL $PACKAGE"
  exit 0
  make_install_root
  test -d "${ROOT_INSTALL}/${PACKAGE_INSTALL_TARGET}/etc" || mkdir -p "${ROOT_INSTALL}/${PACKAGE_INSTALL_TARGET}/etc" 
}

function package {
  echo "PACKAGE $PACKAGE"
  exit 0
  package_dir \
    --depends gmp-devel \
    --provides strace
}

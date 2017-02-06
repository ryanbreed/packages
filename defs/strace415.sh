export PACKAGE="strace"
export PACKAGE_VERSION="4.15"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="http://https://github.com/strace/strace/archive/v4.15.tar.gz"
export d_archive="strace-4.15.tar.gz"


function download {
  download_archive $d_url $d_archive
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies kernel-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./configure 
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

export PACKAGE="libdvdcss"
export PACKAGE_VERSION="1.4.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"

export git_url="http://code.videolan.org/videolan/libdvdcss.git"

function dependencies {
  echo "NO DEPENDENCIES"
  #cd "$ROOT_COMPILE/$PACKAGE"
  #install_buildtime_dependencies openssl-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  autoreconf --install --force
  ./configure \
     --prefix=/opt/$PACKAGE \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share
}

function install_root {
  make_install_root
}

function compile {
  compile_make
}

function package {
echo "NO PACKAGE"
  fpm -t rpm -s dir \
    -C $ROOT_INSTALL/$PACKAGE \
    -p $ARTIFACTS \
    -n $PACKAGE \
    --version $PACKAGE_VERSION \
    --iteration $PACKAGE_ITERATION \
    --provides "$PACKAGE" \
    --inputs $PKG_HOME/mf/$PACKAGE.files
    if [ $? -ne 0 ]; then
      exit 1
    fi
}

function download {
  download_git
}

export PACKAGE="libp11"
export PACKAGE_VERSION="0.4.2"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"

export git_url="https://github.com/opensc/libp11"

function dependencies {
  cd "$ROOT_COMPILE/$PACKAGE"
  install_buildtime_dependencies openssl-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./bootstrap
  ./configure \
     --prefix=/opt/$PACKAGE \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --with-enginesdir=/usr/lib64/openssl/engines \
     --with-pkcs11-module=/usr/lib64/opensc-pkcs11.so \
     --datarootdir=/usr/share
}

function install_root {
  make_install_root
}

function compile {
  compile_make
}

function package {
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

export PACKAGE="opensc"
export PACKAGE_VERSION="0.16.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"

export git_url="https://github.com/opensc/opensc"

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
     --datarootdir=/usr/share \
     --enable-readline \
     --enable-zlib \
     --enable-openssl \
     --with-pcsc-provider=/usr/lib64/libpcsclite.so # \
     #--with-pkcs11-provider=/usr/lib64/p11-kit-proxy.so
}

function install_root {
  make_install_root
}

function compile {
  compile_make
}

function package {
  package_dir
}

function download {
  download_git
}

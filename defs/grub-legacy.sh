export PACKAGE="grub-legacy"
export PACKAGE_VERSION="0.97.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="ftp://alpha.gnu.org/gnu/grub/grub-0.97.tar.gz"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./configure \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --prefix=/opt/$PACKAGE 
  exit 0
}

function install_root {
  echo "INSTALL $PACKAGE"
  make_install_root
  test -d $ROOT_INSTALL/$PACKAGE/opt/$PACKAGE/etc || mkdir -p $ROOT_INSTALL/$PACKAGE/opt/$PACKAGE/etc
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir \
    --depends openssl --depends luajit --depends libnfnetlink --depends libpcap --depends libdnet --depends hwloc-libs \
    --provides daq
}

export PACKAGE="daq2"
export PACKAGE_VERSION="2.2.1"
export PACKAGE_ITERATION="3"
export MAKEFLAGS="-j8 --silent"
export d_url="https://www.snort.org/downloads/snortplus/daq-2.2.1.tar.gz"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel openssl-devel luajit luajit-devel libnfnetlink-devel pcre pcre-devel libpcap-devel libdnet libdnet-devel hwloc-devel hwloc-libs hwloc
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./configure \
     --silent \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --prefix=/opt/$PACKAGE 
}

function install_root {
  echo "INSTALL $PACKAGE"
  make_install_root
  mkdir -p $ROOT_INSTALL/$PACKAGE/opt/$PACKAGE/etc
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir \
    --depends openssl --depends luajit --depends libnfnetlink --depends libpcap --depends libdnet --depends hwloc-libs \
    --provides daq
}

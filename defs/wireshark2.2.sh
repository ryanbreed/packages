export PACKAGE="wireshark2"
export PACKAGE_VERSION="2.2.4"
export PACKAGE_ITERATION="1"
export MAKEFLAGS="-j8 --silent"
export d_url="https://2.na.dl.wireshark.org/src/wireshark-2.2.4.tar.bz2"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel openssl-devel libpcap-devel libssh-devel qt3-devel 
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./configure \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --enable-wireshark \
     --with-qt=4 \
     --with-lua=yes \
     --enable-sshdump \
     --enable-tfshark \
     --prefix=/opt/$PACKAGE 
}

function install_root {
  echo "INSTALL $PACKAGE"
  make_install_root
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir
}

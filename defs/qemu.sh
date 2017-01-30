export PACKAGE="qemu"
export PACKAGE_VERSION="2.7.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="http://wiki.qemu-project.org/download/qemu-2.7.0.tar.bz2"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel openssl-devel
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
  #make_install_root
}

function package {
  echo "PACKAGE $PACKAGE"
  #package_dir
}

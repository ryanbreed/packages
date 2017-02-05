export PACKAGE="openvswitch26"
export PACKAGE_VERSION="2.6.1"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="http://openvswitch.org/releases/openvswitch-2.6.1.tar.gz"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url $d_archive
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel NetworkManager-glib-devel NetworkManager-libnm-devel pam-devel libiptcdata-devel NetworkManager-devel pam-devel iptables-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  rbenv local system
  ./configure \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --prefix=/opt/$PACKAGE 
    exit 0
}

function install_root {
  echo "INSTALL"
  exit 0
  make_install_root
}

function package {
  echo "PACKAGE"
  exit 0
  package_dir
}

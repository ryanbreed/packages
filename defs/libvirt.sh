export PACKAGE="libvirt"
export PACKAGE_VERSION="3.0.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="http://libvirt.org/sources/libvirt-3.0.0.tar.xz"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel openssl-devel libpciaccess-devel device-mapper-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
     #--silent \
  ./configure \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --with-openssl=yes \
     --with-init-script=systemd \
     --with-audit \
     --with-libvirtd \
     --with-qemu=/opt/qemu \
     --with-qemu-user=qemu \
     --with-qemu-group=qemu \
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

export PACKAGE="strongswan"
export PACKAGE_VERSION="5.5.1"
export PACKAGE_ITERATION="1"
export MAKEFLAGS="-j8 --silent"
export d_url="https://download.strongswan.org/strongswan-5.5.1.tar.gz"
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
     --silent \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --prefix=/opt/$PACKAGE \
     --enable-openssl --enable-pkcs11 \
     --with-user=vpn \
     --enable-curl --enable-files \
     --enable-acert \
     --enable-eap-sim \
     --enable-eap-sim-file \
     --enable-eap-sim-pcsc \
     --enable-eap-tls \
     --enable-eap-ttls \
     --enable-ext-auth \
     --enable-whitelist \
     --enable-xauth-eap \
     --enable-xauth-pam \
     --enable-xauth-noauth \
     --enable-kernel-libipsec \
     --enable-certexpire \
     --enable-forecast \
     --enable-duplicheck \
     --enable-connmark \
     --enable-farp \
     --enable-libipsec \
     --enable-nm \
     --enable-systemd  \
     --enable-dhcp \
     --enable-ruby-gems \
     --enable-python-eggs \
     --with-capabilities=libcap
}

function install_root {
  make_install_root
}

function package {
  package_dir
}

export PACKAGE="snort3"
export PACKAGE_VERSION="3.0.0"
export PACKAGE_ITERATION="3"
export MAKEFLAGS="-j8 --silent"
export d_url="https://www.snort.org/downloads/snortplus/snort-3.0.0-a4-223-auto.tar.gz"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel openssl-devel luajit luajit-devel libnfnetlink-devel pcre pcre-devel libpcap-devel libdnet libdnet-devel hwloc-devel hwloc-libs hwloc daq2
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
     # --silent \
  ./configure \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --enable-large-pcap \
     --enable-shell \
     --prefix=/opt/$PACKAGE 
}

function install_root {
  echo "INSTALL $PACKAGE"
  make_install_root
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir --depends daq2 --depends luajit --depends libnfnetlink \
              --depends pcre --depends libpcap  --depends libdnet \
              --depends hwloc-libs \
              --provides snort --provides snort3
}

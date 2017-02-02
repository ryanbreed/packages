export PACKAGE="php5630"
export PACKAGE_VERSION="5.6.30"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="http://php.net/get/php-5.6.30.tar.gz/from/this/mirror"
export d_archive="php-5.6.30.tar.gz"

export PACKAGE_INSTALL_TARGET="/app/php/${PACKAGE_VERSION}"

function download {
  download_archive $d_url $d_archive
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel openssl-devel readline-devel libyaml-devel yajl-devel openldap-devel gd-devel freetype-devel freetds-devel expat-devel libxml2-devel libxml-devel libzip-devel libxslt-devel gmp-devel cyrus-sasl-devel cyrus-sasl-gssapi cyrus-sasl-ldap cyrus-imapd-devel pcre-devel xmlrpc-c-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./configure \
    --prefix=/app/php/5.6.30 \
    --build=x86_64-unknown-linux-gnu \
    --disable-ipv6  \
    --enable-dba=shared \
    --enable-exif \
    --enable-ftp \
    --enable-soap \
    --enable-sockets \
    --enable-wddx  \
    --enable-zip \
    --enable-intl \
    --with-xsl=/usr \
    --with-iconv-dir=/usr \
    --with-pdo-pgsql=/usr/pgsql-9.6
}

function make_install_root {
  cd "${ROOT_COMPILE}/${PACKAGE}"
  export ddir="${ROOT_INSTALL}/${PACKAGE}"
  echo "cleaning install root"
  rm -rvf "$ddir"
  test -d "$ddir" || mkdir -vp "$ddir"
  echo "installing to $ddir"
  make install DESTDIR="$ddir" INSTALL_ROOT="$ddir"
  test -d $ddir/opt/$PACKAGE/etc || mkdir -p $ddir/opt/$PACKAGE/etc
}

function install_root {
  echo "INSTALL $PACKAGE"
  make_install_root
  test -d "${ROOT_INSTALL}/${PACKAGE_INSTALL_TARGET}/etc" || mkdir -p "${ROOT_INSTALL}/${PACKAGE_INSTALL_TARGET}/etc" 
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir \
    --provides php --provides php56 --provides php5630 
}

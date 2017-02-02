export PACKAGE="ruby233"
export PACKAGE_VERSION="2.3.3"
export PACKAGE_ITERATION="2"
export MAKEFLAGS="-j8 --silent"
export d_url="http://cache.ruby-lang.org/pub/ruby/2.3/ruby-${PACKAGE_VERSION}.tar.gz"
export d_archive=$( basename $d_url )

export PACKAGE_INSTALL_TARGET="/app/ruby/${PACKAGE_VERSION}"

function download {
  download_archive $d_url
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies libcurl-devel openssl-devel readline-devel libyaml-devel yajl-devel
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./configure \
     --prefix="${PACKAGE_INSTALL_TARGET}" \
     --enable-shared \
     --with-soname=${PACKAGE} 
}

function install_root {
  echo "INSTALL $PACKAGE"
  make_install_root
  test -d "${ROOT_INSTALL}/${PACKAGE_INSTALL_TARGET}/etc" || mkdir -p "${ROOT_INSTALL}/${PACKAGE_INSTALL_TARGET}/etc" 
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir \
    --depends libcurl --depends openssl --depends readline --depends libyaml --depends yajl \
    --depends gmp-devel \
    --provides ruby --provides ruby233  \
    --after-install hooks/${PACKAGE}/after-install.sh
}

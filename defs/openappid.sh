export PACKAGE="openappid"
export PACKAGE_VERSION="0.1.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="https://www.snort.org/downloads/openappid/4602"
export d_archive="snort-openappid.tar.gz"

function download {
  download_archive $d_url $d_archive
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies luajit
}

function configure {
  /bin/true
}

function install_root {
  echo "INSTALL $PACKAGE"
  cd "${COMPILE_ROOT}/${PACKAGE}"
  export ddir="${ROOT_INSTALL}/${PACKAGE}"
  echo "cleaning install root"
  rm -rvf "$ddir"
  test -d "$ddir" || mkdir -vp "$ddir"
  mkdir -vp "${ddir}/opt/snort/odp"
  extract_archive "$DOWNLOAD/$d_archive" "${ddir}/opt/snort/odp"
}

function package_dir {
  fpm -t rpm -s dir \
    -C $ROOT_INSTALL/$PACKAGE \
    -p $ARTIFACTS \
    -n $PACKAGE \
    --version $PACKAGE_VERSION \
    --iteration $PACKAGE_ITERATION \
    --provides "$PACKAGE" \
    --config-files opt/snort/odp/appid.conf \
    --config-files opt/snort/odp/version.conf \
    --inputs $PKG_HOME/mf/$PACKAGE.files
    if [ $? -ne 0 ]; then
      exit 1
    fi
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir
}

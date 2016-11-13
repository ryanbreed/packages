function download_archive {
  cd $PKG_HOME
  url="$1"
  arc_file=$(basename $url)
  arc_src=$( dirname $url )

  if [ -f "${DOWNLOAD}/${arc_file}" ]; then
    echo "$arc_file already cached in $DOWNLOAD"
  else
    echo "downloading $arc_file from $url"
    cd $DOWNLOAD && curl -L -O --verbose "$url"
  fi
}

function download_git {
  rm -fr "$ROOT_COMPILE/$PACKAGE"
  git clone $git_url "$ROOT_COMPILE/$PACKAGE"
}

function extract_archive {
  cd $PKG_HOME
  archive="$1"
  arc_file=$(basename $archive)
  dst_dir="$ROOT_COMPILE/$PACKAGE"

  if [ -d "$dst_dir" ]; then
     echo "cleaning $dst_dir"
     rm -vrf "$dst_dir/*"
  else
     echo "creating $dst_dir"
     mkdir -v -p "$dst_dir"
  fi
  echo "extracting $arc_file to $dst_dir"
  tar xaf $archive -C "$dst_dir" --strip-components=1
}

function install_buildtime_dependencies {
  cd $PKG_HOME
  echo "installing for build environment: $*"
  sudo yum -y install $*
}

function make_install_root {
  cd "${COMPILE_ROOT}/${PACKAGE}"
  export ddir="${ROOT_INSTALL}/${PACKAGE}"
  echo "cleaning install root"
  rm -rvf "$ddir"
  test -d "$ddir" || mkdir -vp "$ddir"
  echo "installing to $ddir"
  make install DESTDIR="$ddir"
}

function package_dir {
  fpm -t rpm -s dir \
    -C $ROOT_INSTALL/$PACKAGE \
    -p $ARTIFACTS \
    -n $PACKAGE \
    --version $PACKAGE_VERSION \
    --iteration $PACKAGE_ITERATION \
    --provides "$PACKAGE" \
    --config-files opt/$PACKAGE/etc \
    --inputs $PKG_HOME/mf/$PACKAGE.files
    if [ $? -ne 0 ]; then
      exit 1
    fi
}

function compile_make {
  cd "${ROOT_COMPILE}/${PACKAGE}"
  echo "compiling $PACKAGE"
  make
  if [ $? -eq 0 ]; then
    echo "build complete"
  else
    echo "build failed"
    exit 1
  fi
}

function build_package_manifest {
  cd $PKG_HOME
  ddir="${ROOT_INSTALL}/${PACKAGE}"
  mf="${MANIFESTS}/${PACKAGE}.files"
  rm -fv "$mf"
  find "$ddir" -type f | sed -e "s#${ddir}/##" > "$mf"
}
function target_compile {
  echo "${ROOT_COMPILE}/${PACKAGE}"
}

function target_install {
  echo "${ROOT_INSTALL}/${PACKAGE}"
}

function target_manifest {
  echo "${MANIFESTS}/${PACKAGE}.files"
}

function go_home {
  cd $PKG_HOME
} 

function go_compile {
  cd "$(target_compile)"
}

function go_install {
  cd "$(target_install)"
}

function download_archive {
  go_home
  url="$1"
  arc_file="$2"
  test -z "$arc_file" && arc_file=$(basename $url)
  arc_src=$( dirname $url )

  if [ -f "${DOWNLOAD}/${arc_file}" ]; then
    echo "$arc_file already cached in $DOWNLOAD"
  else
    echo "downloading $arc_file from $url"
    cd $DOWNLOAD && curl -L -s "$url" > $arc_file
  fi
}

function download_git {
  git_url="$1"
  git_branch="$2"

  if [[ -z "$git_branch" ]]; then
    git_branch="master"
  fi

  if [[ -d $(target_compile) && -d "$(target_compile)/.git" ]]; then
    ( go_compile && git checkout $git_branch && git pull origin $git_branch )
  else
    rm -fr $(target_compile)
    git clone "$git_url" "$(target_compile)"
    ( go_compile && git checkout "$git_branch")
  fi
}

function extract_archive {
  go_home
  archive="$1"
  dst_dir="$2"

  arc_file=$(basename $archive)

  if [ -d "$(target_compile)" ]; then
     echo "cleaning $(target_compile)"
     rm -vrf "$(target_compile)/*"
  else
     echo "creating $(target_compile)"
     mkdir -v -p "$(target_compile)"
  fi
  echo "extracting $arc_file to $(target_compile)"
  tar xaf $archive -C "$(target_compile)" --strip-components=1
}

function install_buildtime_dependencies {
  go_home
  echo "installing for build environment: $*"
  sudo yum -y install $*
}

function make_install_root {
  go_compile
  echo "cleaning install root"
  rm -rvf "$(target_install)"
  test -d "$(target_install)" || mkdir -vp "$(target_install)"
  echo "installing to $(target_install)"
  make install DESTDIR="$(target_install)"
}

function package_dir {
  go_home
  if [[ -z "$PACKAGE_SIGN" || "$PACKAGE_SIGN" -eq "no" || "$PACKAGE_SIGN" -eq "false" ]]; then
    export SIGN_FLAG=""
  else
    export SIGN_FLAG="--rpm-sign"
  fi
  fpm -t rpm -s dir \
    -C $(target_install) \
    -p $ARTIFACTS/7/x86_64 \
    -n $PACKAGE \
    --version $PACKAGE_VERSION \
    --iteration $PACKAGE_ITERATION \
    --provides "$PACKAGE" \
    --inputs $PKG_HOME/mf/$PACKAGE.files \
    $SIGN_FLAG $*

    if [ $? -ne 0 ]; then
      exit 1
    fi
}

function compile_make {
  go_compile
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
  go_home
  rm -fv "$(target_manifest)"
  find "$(target_install)" -type f | sed -e "s#$(target_install)/##" > "$(target_manifest)"
}

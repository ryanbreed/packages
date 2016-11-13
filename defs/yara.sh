export PACKAGE="yara"
export PACKAGE_VERSION="3.5.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"

export git_url="https://github.com/VirusTotal/yara"

function dependencies {
  #echo "NO DEPENDENCIES"
  cd "$ROOT_COMPILE/$PACKAGE"
  install_buildtime_dependencies python-devel file-devel jansson-devel openssl-devel
}

     #--enable-cuckoo \
function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./bootstrap.sh
  ./configure \
     --exec-prefix=/usr \
     --libdir=/usr/lib64 \
     --includedir=/usr/include \
     --datarootdir=/usr/share \
     --enable-magic \
     --enable-dotnet
  if [ $? -ne 0 ]; then
    echo "configure failed" 
    exit 1
  fi
}

function install_root {
  make_install_root
}

function compile {
  compile_make
}

function package {
  fpm -t rpm -s dir \
    -C $ROOT_INSTALL/$PACKAGE \
    -p $ARTIFACTS \
    -n $PACKAGE \
    --version $PACKAGE_VERSION \
    --iteration $PACKAGE_ITERATION \
    --provides "$PACKAGE" \
    --inputs $PKG_HOME/mf/$PACKAGE.files
    if [ $? -ne 0 ]; then
      exit 1
    fi
}

function download {
  download_git
}

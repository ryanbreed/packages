export PACKAGE="plaso"
export PACKAGE_VERSION="1.5.2"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"

export git_url="https://github.com/log2timeline/plaso"

function dependencies {
  cd "$ROOT_COMPILE/$PACKAGE"
  sudo pip install --upgrade -r requirements.txt
  if [ $? -ne 0 ]; then
    echo "configure failed" 
    exit 1
  fi
}

function configure {
  echo "NO CONFIGURE"
}

function install_root {
  echo "NO INSTALL"
}

function compile {
  cd "$ROOT_COMPILE/$PACKAGE"
  python setup.py bdist_rpm
}

function package {
  cd "$ROOT_COMPILE/$PACKAGE"
  mv -v dist/$PACKAGE-*.noarch.rpm $ARTIFACTS
}

function download {
  download_git
}

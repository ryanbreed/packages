if [[ -z "${PKG_HOME}" ]]; then
  source "build_vars.sh"
fi

export PACKAGE="panopticon"
export PACKAGE_VERSION="0.16.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export git_url="https://github.com/das-labor/panopticon.git"
export git_branch="tags/0.16.0"

export CC=clang

function download {
  download_git "$git_url" "$git_branch"
}

function dependencies {
  install_buildtime_dependencies qt5-qtbase qt5-qtbase-devel qt5-qtbase-gui qt5-qtx11extras-devel rust cargo qt5-qtgraphicaleffects qt5-qtsvg qt5-qtsvg-devel qt5-qtdeclarative-devel qt5-qtquickcontrols cmake adobe-source-sans-pro-fonts adobe-source-code-pro-fonts
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
}

function install_root {
  echo "INSTALL $PACKAGE"
  cargo build
  cargo install --root $(target_install)
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir \
    --provides panopticon
}

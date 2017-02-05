if [[ -z "${PKG_HOME}" ]]; then 
  source "build_vars.sh"
fi

export PACKAGE="grub-legacy"
export PACKAGE_VERSION="0.97.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export d_url="ftp://alpha.gnu.org/gnu/grub/grub-0.97.tar.gz"
export d_archive=$( basename $d_url )

function download {
  download_archive $d_url $d_archive
  extract_archive "$DOWNLOAD/$d_archive"
}

function dependencies {
  install_buildtime_dependencies autoconf automake libcurses-devel compat-glibc compat-glibc-headers autoconf-archive binutils-devel.i686 binutils-devel.x86_64 glibc-devel-2.17-157.el7_3.1.i686
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  echo "configuring $PACKAGE"
  ./configure --prefix=/opt/$PACKAGE 
  # exit 0
}

function install_root {
  echo "INSTALL $PACKAGE"
  make_install_root
  # test -d $ROOT_INSTALL/$PACKAGE/opt/$PACKAGE/etc || mkdir -p $ROOT_INSTALL/$PACKAGE/opt/$PACKAGE/etc
}

function package {
  echo "PACKAGE $PACKAGE"
  #package_dir --provides grub-legacy
}

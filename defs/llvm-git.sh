if [[ -z "${PKG_HOME}" ]]; then
  source "build_vars.sh"
fi

export PACKAGE="llvm-git"
export PACKAGE_VERSION="5.0"
export PACKAGE_ITERATION="0"
export MAKEFLAGS="-j8 --silent"
export git_url="http://llvm.org/git/llvm.git"
export git_branch="master"

function download {
  download_git "$git_url" "$git_branch"
}

function dependencies {
  install_buildtime_dependencies git gcc gcc-c++ cmake3 make zlib-devel bison flex libstdc++-static elfutils-libelf-devel rpm-build
}

function configure {
  cd "$ROOT_COMPILE/$PACKAGE"
  mkdir build
  cd build
  cmake -G "Unix Makefiles" -DLLVM_TARGETS_TO_BUILD="BPF;X86" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/var/tmp/build/rootfs/llvm-git/usr ..
  echo "configuring $PACKAGE"
}

function install_root {
  echo "INSTALL $PACKAGE"
  cd "$ROOT_COMPILE/$PACKAGE/build"
  make -j8
  make install
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir --provides llvm
}

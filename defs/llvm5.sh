if [[ -z "${PKG_HOME}" ]]; then
  source "build_vars.sh"
fi

export PACKAGE="llvm5"
export PACKAGE_VERSION="5.0"
export PACKAGE_ITERATION="0"
export PACKAGE_SIGN="yes"
export MAKEFLAGS="-j15 --silent"
export git_url="http://llvm.org/git/llvm.git"
export git_branch="master"

function download {
  download_git "$git_url" "$git_branch"
  if [[ -d $(target_compile)/tools/clang/.git ]]; then 
    ( go_compile && cd tools/clang && git pull origin master )
  else
    ( go_compile && cd tools && git clone http://llvm.org/git/clang.git )
  fi
}

function dependencies {
  install_buildtime_dependencies git gcc gcc-c++ cmake3 make zlib-devel bison flex libstdc++-static elfutils-libelf-devel rpm-build
}

function configure {
  go_compile
  rm -fr build
  mkdir build
  cd build
  cmake -G "Unix Makefiles" -DLLVM_TARGETS_TO_BUILD="BPF;X86" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$(target_install)/opt/${PACKAGE}" ..
  echo "configuring $PACKAGE"
}

function install_root {
  echo "INSTALL $PACKAGE"
  cd "$ROOT_COMPILE/$PACKAGE/build"
  make
  make install
}

function package {
  echo "PACKAGE $PACKAGE"
  package_dir --force --provides llvm
}

#!/bin/bash
VERSION_bitarray=0.8.1
DEPS_bitarray=(hostpython python)
URL_bitarray=https://pypi.python.org/packages/source/b/bitarray/bitarray-$VERSION_bitarray.tar.gz
MD5_bitarray=3825184f54f4d93508a28031b4c65d3b
BUILD_bitarray=$BUILD_PATH/bitarray/$(get_directory $URL_bitarray)
RECIPE_bitarray=$RECIPES_PATH/bitarray

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_bitarray() {
	true
}

# function called to build the source code
function build_bitarray() {

    if [ -d "$BUILD_PATH/python-install/lib/python2.7/site-packages/bitarray" ]; then
		return
	fi

	cd $BUILD_bitarray
	push_arm
	export EXTRA_CFLAGS="--host linux-armv"
	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2
	pop_arm
}

# function called after all the compile have been done
function postbuild_bitarray() {
	true
}


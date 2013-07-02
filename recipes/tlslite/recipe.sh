#!/bin/bash
VERSION_tlslite=0.4.6
DEPS_tlslite=(hostpython python)
URL_tlslite=https://pypi.python.org/packages/source/t/tlslite/tlslite-$VERSION_tlslite.tar.gz
MD5_tlslite=2f92ebea557802969653f29c7faafbc2
BUILD_tlslite=$BUILD_PATH/tlslite/$(get_directory $URL_tlslite)
RECIPE_tlslite=$RECIPES_PATH/tlslite

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_tlslite() {
	true
}

# function called to build the source code
function build_tlslite() {

    if [ -d "$BUILD_PATH/python-install/lib/python2.7/site-packages/tlslite" ]; then
		return
	fi

	cd $BUILD_tlslite
	push_arm
	export EXTRA_CFLAGS="--host linux-armv"
	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2
	pop_arm
}

# function called after all the compile have been done
function postbuild_tlslite() {
	true
}


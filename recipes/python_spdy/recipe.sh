#!/bin/bash
VERSION_python_spdy=0.4.6
DEPS_python_spdy=(hostpython python)
URL_python_spdy=https://github.com/fqrouter/python-spdy/archive/master.zip
MD5_python_spdy=
BUILD_python_spdy=$BUILD_PATH/python_spdy/master
RECIPE_python_spdy=$RECIPES_PATH/python_spdy

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_python_spdy() {
	true
}

# function called to build the source code
function build_python_spdy() {

    if [ -d "$BUILD_PATH/python-install/lib/python2.7/site-packages/spdy" ]; then
		return
	fi

	cd $BUILD_python_spdy
	push_arm
	export EXTRA_CFLAGS="--host linux-armv"
	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2
	pop_arm
}

# function called after all the compile have been done
function postbuild_python_spdy() {
	true
}


#!/bin/bash

URL_m2crypto=https://pypi.python.org/packages/source/M/M2Crypto/M2Crypto-0.21.1.tar.gz
DEPS_m2crypto=(python)
MD5_m2crypto=f93d8462ff7646397a9f77a2fe602d17
BUILD_m2crypto=$BUILD_PATH/m2crypto/$(get_directory $URL_m2crypto)
RECIPE_m2crypto=$RECIPES_PATH/m2crypto


function prebuild_m2crypto() {
	true
}

function build_m2crypto() {
	cd $BUILD_m2crypto

	if [ -d "$BUILD_PATH/python-install/lib/python2.7/site-packages/M2Crypto" ]; then
		return
	fi

	push_arm

	try $BUILD_PATH/python-install/bin/python.host setup.py build_ext
	try find . -iname '*.pyx' -exec cython {} \;
	try $BUILD_PATH/python-install/bin/python.host setup.py build_ext -v
	try find build/lib.* -name "*.o" -exec $STRIP {} \;

	export PYTHONPATH=$BUILD_hostpython/Lib/site-packages
	try $BUILD_hostpython/hostpython setup.py install -O2 --root=$BUILD_PATH/python-install --install-lib=lib/python2.7/site-packages

	pop_arm
}

function postbuild_m2crypto() {
	true
}

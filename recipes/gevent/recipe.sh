#!/bin/bash

VERSION_gevent=1.0
URL_gevent=https://pypi.python.org/packages/source/g/gevent/gevent-1.0.tar.gz
DEPS_gevent=(greenlet hostpython python)
MD5_gevent=33aef51a06268f5903fea378e1388e4d
BUILD_gevent=$BUILD_PATH/gevent/$(get_directory $URL_gevent)
RECIPE_gevent=$RECIPES_PATH/gevent

function prebuild_gevent() {
	true
}

function build_gevent() {

    if [ -d "$BUILD_PATH/python-install/lib/python2.7/site-packages/gevent" ]; then
        return
    fi

	cd $BUILD_gevent

	push_arm

    export GEVENT_RESOLVER="ares"
    export CC="$CC -DANDROID" 
	try patch -p1 < $RECIPE_gevent/android.patch

	try $BUILD_PATH/python-install/bin/python.host setup.py build
	try find build/lib.* -name "*.o" -exec $STRIP {} \;
	try find build/lib.* -name "*.so" -exec $STRIP {} \;

	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2 

	pop_arm
}

function postbuild_gevent() {
	true
}

function shouldbuild_gevent() {
	if [ -d "$SITEPACKAGES_PATH/gevent" ]; then
		DO_BUILD=0
	fi
}

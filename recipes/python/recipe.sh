#!/bin/bash

VERSION_python=3.3.2
DEPS_python=(hostpython)
URL_python=http://python.org/ftp/python/$VERSION_python/Python-$VERSION_python.tar.bz2
MD5_python=7dffe775f3bea68a44f762a3490e5e28

# must be generated ?
BUILD_python=$BUILD_PATH/python/$(get_directory $URL_python)
RECIPE_python=$RECIPES_PATH/python

function prebuild_python() {
	cd $BUILD_python

	# check marker in our source build
	if [ -f .patched ]; then
		# no patch needed
		return
	fi

	try cp $RECIPE_python/config.site .
	try patch -p1 < $RECIPE_python/fix-$VERSION_python.patch

	# everything done, touch the marker !
	touch .patched
}

function build_python() {
	# placeholder for building
	cd $BUILD_python

	# if the last step have been done, avoid all
	if [ -f $BUILD_PATH/python-install/lib/libpython3.3m.so.1.0 ]; then
		return
	fi

	push_arm

	# openssl activated ?
	if [ "X$BUILD_openssl" != "X" ]; then
		debug "Activate flags for openssl / python"
		export CFLAGS="$CFLAGS -I$BUILD_openssl/include/"
		export LDFLAGS="$LDFLAGS -L$BUILD_openssl/"
	fi

	# sqlite3 activated ?
	if [ "X$BUILD_sqlite3" != "X" ]; then
		debug "Activate flags for sqlite3"
		export CFLAGS="$CFLAGS -I$BUILD_sqlite3"
		export LDFLAGS="$LDFLAGS -L$SRC_PATH/obj/local/$ARCH/"
	fi

    export CFLAGS="$CFLAGS -DANDROID"
    export PATH=$PATH:$BUILD_PATH/python_host/bin

    try ./configure --host=$TOOLCHAIN_PREFIX --build=x86_64-linux --enable-shared --prefix="$BUILD_PATH/python-install" --disable-ipv6 CONFIG_SITE=config.site --disable-framework

    try cp $RECIPE_python/pyconfig.h pyconfig.h
    try cp $RECIPE_python/Setup Modules/Setup

    # first run
    make INSTSONAME=libpython3.3m.so

    # second run
	try cp $BUILD_hostpython/hostpgen Parser/pgen
    try make INSTSONAME=libpython3.3m.so
    try make install INSTSONAME=libpython3.3m.so

	pop_arm

	try cp $BUILD_hostpython/hostpython $BUILD_PATH/python-install/bin/python.host
	try cp libpython3.3m.so $LIBS_PATH/
}


function postbuild_python() {
	# placeholder for post build
	true
}

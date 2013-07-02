#!/bin/bash

URL_python_netfilterqueue=https://github.com/fqrouter/python-netfilterqueue/archive/v0.6.tar.gz
DEPS_python_netfilterqueue=(libnetfilter_queue python)
MD5_python_netfilterqueue=
BUILD_python_netfilterqueue=$BUILD_PATH/python_netfilterqueue/$(get_directory $URL_python_netfilterqueue)
RECIPE_python_netfilterqueue=$RECIPES_PATH/python_netfilterqueue


function prebuild_python_netfilterqueue() {
	true
}

function build_python_netfilterqueue() {
	cd $BUILD_python_netfilterqueue

	if [ -f "$BUILD_PATH/python-install/lib/python2.7/site-packages/netfilterqueue.so" ]; then
		return
	fi

	push_arm

	export CC="$CC -I$RECIPE_libnetfilter_queue/jni/libnfnetlink/include -I$RECIPE_libnetfilter_queue/jni/libnetfilter_queue/include"

	try $BUILD_PATH/python-install/bin/python.host setup.py build_ext -I$RECIPE_libnetfilter_queue/jni/libnfnetlink/include -I$RECIPE_libnetfilter_queue/jni/libnetfilter_queue/include
	try find . -iname '*.pyx' -exec cython {} \;
	try $BUILD_PATH/python-install/bin/python.host setup.py build_ext -v -I$RECIPE_libnetfilter_queue/jni/libnfnetlink/include -I$RECIPE_libnetfilter_queue/jni/libnetfilter_queue/include
	try find build/lib.* -name "*.o" -exec $STRIP {} \;

	export PYTHONPATH=$BUILD_hostpython/Lib/site-packages
	try $BUILD_hostpython/hostpython setup.py install -O2 --root=$BUILD_PATH/python-install --install-lib=lib/python2.7/site-packages

	pop_arm
}

function postbuild_python_netfilterqueue() {
	true
}

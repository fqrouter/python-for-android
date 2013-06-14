#!/bin/bash

VERSION_libnetfilter_queue=
URL_libnetfilter_queue=
MD5_libnetfilter_queue=
BUILD_libnetfilter_queue=$RECIPES_PATH/libnetfilter_queue
RECIPE_libnetfilter_queue=$RECIPES_PATH/libnetfilter_queue

function prebuild_libnetfilter_queue() {
	true
}

function build_libnetfilter_queue() {
	if [ -f "$BUILD_PATH/python-install/lib/libnetfilter_queue.so" ]; then
		return
	fi

	cd $BUILD_libnetfilter_queue
	push_arm
    try ndk-build V=1
    pop_arm
    cp $BUILD_libnetfilter_queue/libs/$ARCH/*.so $BUILD_PATH/python-install/lib
}

function postbuild_libnetfilter_queue() {
	true
}

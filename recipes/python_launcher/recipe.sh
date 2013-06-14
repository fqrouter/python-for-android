#!/bin/bash

VERSION_python_launcher=
DEPS_python_launcher=(python)
URL_python_launcher=
MD5_python_launcher=
BUILD_python_launcher=$RECIPES_PATH/python_launcher
RECIPE_python_launcher=$RECIPES_PATH/python_launcher

function prebuild_python_launcher() {
	true
}

function build_python_launcher() {
	cd $BUILD_python_launcher
	push_arm
    try ndk-build V=1
    pop_arm
}

function postbuild_python_launcher() {
	true
}

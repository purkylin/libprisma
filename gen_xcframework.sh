#!/bin/sh

# -------------- config --------------

# Uncomment for debugging
# set -x

# Set bash script to exit immediately if any commands fail
set -e

# Variables

FRAMEWORK_NAME=$1

TEMP_BUILD_PATH="./build"
SIMULATOR_ARCHIVE_PATH="${TEMP_BUILD_PATH}/iOS_Simulator.xcarchive"
DEVICE_ARCHIVE_PATH="${TEMP_BUILD_PATH}/iOS.xcarchive"
MACOS_ARCHIVE_PATH="${TEMP_BUILD_PATH}/macOS.xcarchive"

OUPUT_PATH_DIR="./build"

# For debugging
echo "Framework name: ${FRAMEWORK_NAME}"
echo "Build dir: ${TEMP_BUILD_PATH}"
echo "Simulator arch dir: ${SIMULATOR_ARCHIVE_PATH}"
echo "Device arch dir: ${DEVICE_ARCHIVE_PATH}"
echo "macOS arch dir: ${MACOS_ARCHIVE_PATH}"

# Remove old files
rm -rf ${TEMP_BUILD_PATH}/*.xcarchive
rm -rf ${OUPUT_PATH_DIR}/*.xcframework
rm -rf ${OUPUT_PATH_DIR}/*.zip

# Archive
xcodebuild archive -scheme ${FRAMEWORK_NAME} \
					-destination "generic/platform=iOS" \
					-archivePath "${DEVICE_ARCHIVE_PATH}"

xcodebuild archive -scheme ${FRAMEWORK_NAME} \
					-destination "generic/platform=iOS Simulator" \
					-archivePath "${SIMULATOR_ARCHIVE_PATH}"

xcodebuild archive -scheme ${FRAMEWORK_NAME} \
					-destination "generic/platform=macOS" \
					-archivePath "${MACOS_ARCHIVE_PATH}"

# XCFramework
xcodebuild  -create-xcframework \
			-framework ${DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
			-framework ${MACOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
			-framework ${SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
			-output ${OUPUT_PATH_DIR}/${FRAMEWORK_NAME}.xcframework

# Distribute
cd ${OUPUT_PATH_DIR} && zip -r ${FRAMEWORK_NAME}.zip ${FRAMEWORK_NAME}.xcframework && cd - > /dev/null
echo "Calculate checksum"
swift package compute-checksum ${OUPUT_PATH_DIR}/${FRAMEWORK_NAME}.zip

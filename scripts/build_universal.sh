set -e
set +u
# avoid recursively calling this script.
if [[ $SF_MASTER_SCRIPT_RUNNING ]]
then
exit 0
fi
set -u
export SF_MASTER_SCRIPT_RUNNING=1

SF_TARGET_NAME=${PROJECT_NAME}
# if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]]
# then
# SF_SDK_PLATFORM=${BASH_REMATCH[1]}
# else
# echo "Could not find platform name from SDK_NAME: $SDK_NAME"
# exit 1
# fi

# if [[ "$SDK_NAME" =~ ([0-9]+.*$) ]]
# then
# SF_SDK_VERSION=${BASH_REMATCH[1]}
# else
# echo "Could not find sdk version from SDK_NAME: $SDK_NAME"
# exit 1
# fi

SF_WRAPPER_NAME="${SF_TARGET_NAME}.framework"
SF_BUILT_PRODUCTS_DIR="${PROJECT_DIR}/Build"

# xcodebuild -target "${PROJECT_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

# generate buids on derived data for iphoneos and iphonesimulator
xcrun xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration "${CONFIGURATION}" -sdk "iphonesimulator" \
BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" SYMROOT="${SYMROOT}" $ACTION

xcrun xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration "${CONFIGURATION}" -sdk "iphoneos" \
BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" SYMROOT="${SYMROOT}" $ACTION

# emove build directory to store new build
rm -rf ${SF_BUILT_PRODUCTS_DIR}/${CONFIGURATION}

if [ ! -d "${SF_BUILT_PRODUCTS_DIR}/${CONFIGURATION}/" ]; then
    mkdir -p "${SF_BUILT_PRODUCTS_DIR}/${CONFIGURATION}/"
fi

# copy the framework structure from iphoneos build to the universal folder
cp -a "${BUILD_DIR}/${CONFIGURATION}-iphoneos/." "${SF_BUILT_PRODUCTS_DIR}/${CONFIGURATION}/"

# (SWIFT ONLY) copy Swift modules from iphonesimulator build to the copied framework directory
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${SF_WRAPPER_NAME}/Modules/${PROJECT_NAME}.swiftmodule/." "${SF_BUILT_PRODUCTS_DIR}/${CONFIGURATION}/${SF_WRAPPER_NAME}/Modules/${PROJECT_NAME}.swiftmodule"

lipo -create -output "${SF_BUILT_PRODUCTS_DIR}/${CONFIGURATION}/${SF_WRAPPER_NAME}/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${SF_WRAPPER_NAME}/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${SF_WRAPPER_NAME}/${PROJECT_NAME}"

# Copy framework to Client project
CLIENT_FRAMEWORK_DIR="Frameworks"

rm -rf "${PROJECT_DIR}/${CLIENT_FRAMEWORK_DIR}/${SF_WRAPPER_NAME}"
cp -af "${SF_BUILT_PRODUCTS_DIR}/${CONFIGURATION}/${SF_WRAPPER_NAME}" "${PROJECT_DIR}/${CLIENT_FRAMEWORK_DIR}/"

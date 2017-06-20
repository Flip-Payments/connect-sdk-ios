#!/bin/bash
# fail if any commands fails
set -e

FRAMEWORK_NAME=FlipConnectSDK

brew update
brew outdated carthage || brew upgrade carthage
carthage build --no-skip-current
carthage archive $FRAMEWORK_NAME
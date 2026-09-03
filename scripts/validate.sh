#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
swift test
xcodebuild -scheme SwiftBits -destination 'generic/platform=iOS Simulator' -derivedDataPath .build/validation CODE_SIGNING_ALLOWED=NO build
xcodebuild -scheme SwiftBits -destination 'generic/platform=macOS' -derivedDataPath .build/documentation CODE_SIGNING_ALLOWED=NO OTHER_DOCC_FLAGS='--warnings-as-errors' docbuild

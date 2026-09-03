#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
swift build --product SwiftBitsDemo
binary_dir="$(swift build --show-bin-path)"
bundle_dir="$PWD/.build/SwiftBitsDemo.app"
mkdir -p "$bundle_dir/Contents/MacOS"
cp "$binary_dir/SwiftBitsDemo" "$bundle_dir/Contents/MacOS/SwiftBitsDemo"
cat > "$bundle_dir/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>SwiftBitsDemo</string>
<key>CFBundleIdentifier</key><string>dev.swiftbits.demo</string>
<key>CFBundleName</key><string>SwiftBits Demo</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>LSMinimumSystemVersion</key><string>26.0</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
open "$bundle_dir"

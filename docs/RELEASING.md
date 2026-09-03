# Releasing SwiftBits

The package is in the 0.x MVP stage. `main` is the development branch. Publish a version only after the checks below; do not describe untagged code as an available release.

1. Run `scripts/validate.sh` with Xcode 26+ and verify CI is green for the exact commit.
2. Complete the manual [accessibility review](ACCESSIBILITY.md) on macOS and iOS.
3. Review every README/DocC snippet and confirm the public API is intentional.
4. Move `Unreleased` changelog entries under the chosen semantic version and date.
5. Check `Preview/index.html`, the only preview surface, and confirm its examples and stated coverage are current.
6. Commit the release notes, create an annotated version tag (for example `git tag -a 0.1.0 -m "SwiftBits 0.1.0"`), then push that tag.
7. Publish a GitHub release using the matching changelog section. Update README installation to the tagged version and verify a clean consumer can resolve it.

Patch releases fix compatible behavior. Minor 0.x releases may change APIs with migration notes. A 1.0 release commits to stable public API compatibility within the major version.

CI builds and tests on macOS, compiles for iOS Simulator, and builds DocC with warnings treated as errors. Documentation archives are attached to CI runs; hosting a documentation website is optional and separate from shipping the Swift package.

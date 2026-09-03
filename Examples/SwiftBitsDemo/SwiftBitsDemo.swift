import SwiftUI
import SwiftBits
#if os(macOS)
import AppKit

@main
struct SwiftBitsDemo: App {
    init() {
        if #available(macOS 26.0, *), CommandLine.arguments.contains("--snapshot") {
            MainActor.assumeIsolated {
                let renderer = ImageRenderer(content: Showcase().frame(width: 1200, height: 850).environment(\.colorScheme, .dark))
                renderer.scale = 2
                if let image = renderer.nsImage,
                   let tiff = image.tiffRepresentation,
                   let png = NSBitmapImageRep(data: tiff)?.representation(using: .png, properties: [:]) {
                    let path = CommandLine.arguments.last!
                    do { try png.write(to: URL(fileURLWithPath: path)) }
                    catch { fatalError("Snapshot write failed: \(error)") }
                } else { fatalError("Snapshot rendering failed") }
            }
            exit(0)
        }
    }

    var body: some Scene {
        WindowGroup("SwiftBits") {
            if #available(macOS 26.0, *) {
                SwiftBitsGallery().frame(minWidth: 400, minHeight: 600)
            } else {
                Text("The gallery requires macOS 26 or later.").padding()
            }
        }
    }
}

// This editorial overview is rendered from the actual SwiftUI components.
@available(macOS 26.0, *)
private struct Showcase: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("SWIFTBITS / THE COMPONENT COLLECTION").font(.subheadline.monospaced()).foregroundStyle(.orange)
                    Text("Small details.\nRemarkable interfaces.").font(.largeTitle.bold())
                    Text("Native SwiftUI. Thoughtful interactions. Yours to compose.").foregroundStyle(.secondary)
                }
                Spacer()
                StatusBadge("14 components + 1 effect", systemImage: "square.grid.2x2", tint: .orange)
            }
            Grid(horizontalSpacing: 18, verticalSpacing: 18) {
                GridRow {
                    tile("01 / BUTTONS", title: "Give actions character") {
                        GlowButton("Create something", tint: .indigo) {}
                        MorphingButton("Save", state: .success, tint: .green) {}
                    }
                    tile("02 / TEXT", title: "Make numbers move") {
                        RollingNumber(12840, format: .number).font(.largeTitle.bold())
                        Text("A little momentum, built in.").foregroundStyle(.secondary)
                    }
                    tile("03 / FEEDBACK", title: "Show the next step") {
                        ProgressRing(value: 0.72, tint: .orange).frame(width: 112, height: 112)
                    }
                }
                GridRow {
                    tile("04 / CONTROLS", title: "Find your favorites") {
                        FlowLayout {
                            FilterChip("SwiftUI", isSelected: .constant(true), tint: .indigo)
                            FilterChip("Motion", isSelected: .constant(false))
                            StatusBadge("Ready to use", systemImage: "checkmark.circle", tint: .green)
                        }
                    }
                    tile("05 / CARDS", title: "Room for the details") {
                        ExpandableCard(isExpanded: .constant(true)) {
                            Text("Made to compose").font(.headline)
                        } detail: {
                            Text("Your content. Your controls.\nA natural place for both.").foregroundStyle(.secondary)
                        }
                    }
                    tile("06 / EMPTY STATES", title: "Every state considered") {
                        EmptyState("A fresh start", systemImage: "tray", message: "Good things go here.")
                    }
                }
            }
            HStack {
                Text("ZERO DEPENDENCIES").font(.caption.monospaced())
                Spacer()
                Text("iOS + macOS  •  Swift Package Manager  •  MIT").font(.caption)
            }.foregroundStyle(.secondary)
        }
        .padding(40)
        .background(Color(nsColor: .windowBackgroundColor))
    }

    private func tile<Content: View>(_ eyebrow: String, title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(eyebrow).font(.caption.monospaced()).foregroundStyle(.orange)
            Text(title).font(.headline)
            Spacer(minLength: 0)
            content()
            Spacer(minLength: 0)
        }
        .padding(22)
        .frame(maxWidth: .infinity, minHeight: 230, maxHeight: .infinity, alignment: .leading)
        .background(.background, in: .rect(cornerRadius: 22))
        .overlay(RoundedRectangle(cornerRadius: 22).strokeBorder(.primary.opacity(0.1)))
    }
}
#else
@main
struct SwiftBitsDemo {
    static func main() { print("Run this demo on macOS 26 or later, or embed SwiftBitsGallery in your iOS app.") }
}
#endif

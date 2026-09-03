import SwiftUI

/// An interactive starting point for exploring the first SwiftBits collection.
@available(iOS 26.0, macOS 26.0, *)
public struct SwiftBitsGallery: View {
    @State private var phrase = "Hello, SwiftBits"
    @State private var score = 1234.5
    @State private var confirmed = false
    @State private var buttonState = MorphingButton.State.idle
    @State private var expanded = false
    @State private var loading = true
    @State private var selectedTab = 0

    @State private var favoritesOnly = true
    @State private var progress = 0.72
    @Environment(\.layoutDirection) private var layoutDirection

    public init() {}

    public var body: some View {
        CollapsingHeader(tabs: [0, 1], selection: $selectedTab) { progress in
            VStack(alignment: .leading) {
                Text("SwiftBits").font(progress < 0.5 ? .largeTitle.bold() : .headline)
                if progress < 0.5 { Text("An expressive SwiftUI collection").foregroundStyle(.secondary) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity)
            .background(.background)
        } tabLabel: { tab in
            Label(tab == 0 ? "Components" : "Scrolling", systemImage: tab == 0 ? "square.grid.2x2" : "scroll")
        } content: { tab in
            if tab == 0 { components }
            else {
                LazyVStack(alignment: .leading, spacing: 20) {
                    Text("Scroll down to collapse, then up to restore the shared header.")
                    ForEach(0..<40) { index in Text("Row \(index + 1)").padding() }
                }.padding()
            }
        }
    }

    private var components: some View {
        VStack(alignment: .leading, spacing: 28) {
            GroupBox("GlowButton & Shimmer") {
                VStack(spacing: 16) {
                    GlowButton("Make something great", tint: .indigo) { score += 100 }
                    RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                        .frame(height: 24).shimmer()
                }.padding(8)
            }
            GroupBox("FilterChip · FlowLayout · StatusBadge") {
                FlowLayout(layoutDirection: layoutDirection) {
                    FilterChip("Favorites", systemImage: "star", isSelected: $favoritesOnly)
                    FilterChip("All components", isSelected: .constant(true), tint: .indigo)
                    StatusBadge("Available", systemImage: "checkmark.circle.fill", tint: .green)
                }.padding(8)
            }
            GroupBox("ProgressRing") {
                VStack {
                    ProgressRing(value: progress, tint: .indigo).frame(width: 120, height: 120)
                    Slider(value: $progress).accessibilityLabel("Completion")
                }.padding(8)
            }
            GroupBox("EmptyState") {
                EmptyState("Your collection starts here", systemImage: "square.stack.3d.up",
                           message: "Save components to keep inspiration close.") {
                    Button("Save a favorite") { favoritesOnly = true }
                }
            }
            GroupBox("ScrambleText") {
                VStack(alignment: .leading) {
                    ScrambleText(phrase).font(.title2.monospaced())
                    Button("Change text") { phrase = phrase == "Hello, SwiftBits" ? "Make it move" : "Hello, SwiftBits" }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            GroupBox("RollingNumber") {
                VStack(alignment: .leading) {
                    RollingNumber(score, format: .number.precision(.fractionLength(1))).font(.largeTitle)
                    HStack {
                        Button("Decrease") { score -= 123.4 }
                        Button("Increase") { score += 123.4 }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            GroupBox("HoldToConfirmButton") {
                VStack {
                    HoldToConfirmButton { confirmed = true }
                    Text(confirmed ? "Confirmed" : "Release early to cancel")
                    if confirmed { Button("Reset") { confirmed = false } }
                }
            }
            GroupBox("MorphingButton") {
                VStack {
                    MorphingButton("Save", state: buttonState) { buttonState = .loading }
                    Picker("Preview state", selection: $buttonState) {
                        ForEach(MorphingButton.State.allCases, id: \.self) { state in
                            Text(state.rawValue.capitalized).tag(state)
                        }
                    }
                }
            }
            SpotlightCard {
                VStack(alignment: .leading) {
                    Text("SpotlightCard").font(.headline)
                    Text("Move your pointer or drag across this card.")
                }
            }
            ExpandableCard(isExpanded: $expanded) {
                Text("ExpandableCard").font(.headline)
            } detail: {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Details expand inside the card and can contain controls.")
                    Button("Close details") { expanded = false }
                }
            }
            GroupBox("SkeletonView") {
                VStack(alignment: .leading) {
                    Toggle("Loading", isOn: $loading)
                    SkeletonView(isLoading: loading) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill").font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text("Taylor Morgan").font(.headline)
                                Text("A representative subtitle").foregroundStyle(.secondary)
                            }
                        }.padding(.vertical)
                    }
                }
            }
        }.padding()
    }
}

@available(iOS 26.0, macOS 26.0, *)
#Preview("SwiftBits collection") {
    SwiftBitsGallery()
}

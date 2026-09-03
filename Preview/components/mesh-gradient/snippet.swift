import SwiftUI
import SwiftBits

@available(iOS 18.0, macOS 15.0, *)
struct MeshGradientBackgroundExample: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("SwiftBits").font(.largeTitle.bold())
            Text("Expressive SwiftUI").font(.headline)
        }
        .foregroundStyle(.white)
        .padding(40)
        .background(MeshGradientBackground())
    }
}

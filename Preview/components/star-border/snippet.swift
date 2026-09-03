import SwiftUI
import SwiftBits

struct StarBorderExample: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("SwiftBits").font(.headline)
            Text("Rotating gradient border").font(.caption).foregroundStyle(.secondary)
        }
        .padding(24)
        .starBorder(cornerRadius: 18)
    }
}

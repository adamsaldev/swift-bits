import SwiftUI
import SwiftBits

struct StatusBadgeExample: View {
    var body: some View {
        StatusBadge("Synced", systemImage: "checkmark.circle", tint: .green)
    }
}

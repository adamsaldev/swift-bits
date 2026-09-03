import SwiftUI
import SwiftBits

struct ProgressRingExample: View {
    var body: some View {
        ProgressRing(value: 0.72, tint: .blue)
            .frame(width: 120, height: 120)
    }
}

import SwiftUI
import SwiftBits

struct ShimmerExample: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.quaternary)
            .frame(height: 60)
            .shimmer()
    }
}

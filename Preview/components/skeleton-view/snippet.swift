import SwiftUI
import SwiftBits

struct SkeletonViewExample: View {
    var body: some View {
        SkeletonView(isLoading: true) {
            Text("Taylor Morgan")
        }
    }
}

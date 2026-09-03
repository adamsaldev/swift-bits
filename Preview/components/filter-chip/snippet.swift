import SwiftUI
import SwiftBits

struct FilterChipExample: View {
    @State private var isSelected = true

    var body: some View {
        FilterChip("Design", isSelected: $isSelected)
    }
}

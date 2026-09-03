import SwiftUI
import SwiftBits

struct ClickSparkExample: View {
    var body: some View {
        Button("Tap anywhere") { }
            .buttonStyle(.borderedProminent)
            .clickSpark(color: .yellow)
    }
}

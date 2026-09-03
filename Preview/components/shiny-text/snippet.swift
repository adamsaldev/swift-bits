import SwiftUI
import SwiftBits

struct ShinyTextExample: View {
    var body: some View {
        ShinyText("Now shipping", highlight: .white)
            .font(.title.bold())
    }
}

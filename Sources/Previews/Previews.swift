import SwiftUI
import AttributedFont

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct AttributedText_Previews: PreviewProvider {
    
    static let body =
    "Here's to the crazy ones. The misfits. The rebels. "
    + "The troublemakers. The round pegs in the square "
    + "holes. The ones who see things differently. They're "
    + "not fond of rules. And they have no respect for the "
    + "status quo. You can praise them, disagree with them, "
    + "quote them, disbelieve them, glorify or vilify them. "
    + "About the only thing you can't do is ignore them. "
    + "Because they change things."
    
    static var previews: some View {
        VStack {
            AttributedText(body)
            Button<AttributedText>("Read More", action: {})
                .buttonStyle(FilledButtonStyle())
        }
        .attributedFont(
            .custom(
                "Avenir Next",
                fixedSize: 16,
                attributes: .init(
                    kerning: 0,
                    lineHeightMultiple: 1.5
                )
            )
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private extension Button where Label == AttributedText {
    
    init(_ titleKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.init(action: action) {
            AttributedText(titleKey)
        }
    }
    
    init<S: StringProtocol>(_ title: S, action: @escaping () -> Void) {
        self.init(action: action) {
            AttributedText(title)
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12).fill(.blue)
            )
    }
}

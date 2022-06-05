import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AttributedText: View {
    
    @Environment(\.attributedFont) private var environmentAttributedFont: AttributedFont?
    
    internal var text: Text
    internal var modifiedAttributedFont: AttributedFont?
    
    internal var attributedFont: AttributedFont? {
        return modifiedAttributedFont ?? environmentAttributedFont
    }
    
    public init(text: Text) {
        self.text = text
    }
    
    public var body: some View {
        text
            .font(attributedFont?.font)
            .kerning(attributedFont?.attributes.kerning ?? 0)
            .tracking(attributedFont?.attributes.tracking ?? 0)
            .lineSpacing(attributedFont?.lineSpacing ?? 0)
            .padding(.vertical, (attributedFont?.lineSpacing?.rounded()).flatMap { $0 / 2 })
    }
}

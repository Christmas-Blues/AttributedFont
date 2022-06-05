import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AttributedFont: Hashable {
    
    public internal(set) var name: String
    public internal(set) var size: CGFloat
    public internal(set) var attributes: Attributes
    
    public internal(set) var font: Font
    public internal(set) var ctFont: CTFont
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    internal init(name: String, fixedSize: CGFloat, attributes: Attributes) {
        self.name = name
        self.size = fixedSize
        self.attributes = attributes
        
        self.font = .custom(name, fixedSize: fixedSize)
        self.ctFont = CTFontCreateWithName(name as CFString, size, nil)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedFont {
    
    public struct Attributes: Hashable {
        
        public internal(set) var kerning: CGFloat?
        public internal(set) var tracking: CGFloat?
        public internal(set) var lineHeightMultiple: CGFloat?
        
        public init(kerning: CGFloat? = nil, tracking: CGFloat? = nil, lineHeightMultiple: CGFloat? = nil) {
            self.kerning = kerning
            self.tracking = tracking
            self.lineHeightMultiple = lineHeightMultiple
        }
    }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedFont {
    
    public var lineSpacing: CGFloat? {
        guard let lineHeightMultiple = attributes.lineHeightMultiple else {
            return nil
        }
        let originalLineHeight = CTFontGetLineHeight(ctFont)
        let customLineHeight = originalLineHeight * lineHeightMultiple
        guard customLineHeight > originalLineHeight else {
            return nil
        }
        let lineSpacing = customLineHeight - originalLineHeight
        return lineSpacing
    }
}

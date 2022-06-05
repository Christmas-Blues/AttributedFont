import SwiftUI

// MARK: Creating Custom Fonts

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedFont {
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static func custom(_ name: String, fixedSize: CGFloat, attributes: Attributes) -> Self {
        return .init(name: name, fixedSize: fixedSize, attributes: attributes)
    }
}

// MARK: Styling a Font

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedFont {
    
    public func italic() -> Self {
        var modified = self
        modified.font = modified.font.italic()
        return modified
    }
    
    public func smallCaps() -> Self {
        var modified = self
        modified.font = modified.font.smallCaps()
        return modified
    }
    
    public func lowercaseSmallCaps() -> Self {
        var modified = self
        modified.font = modified.font.lowercaseSmallCaps()
        return modified
    }
    
    public func uppercaseSmallCaps() -> Self {
        var modified = self
        modified.font = modified.font.uppercaseSmallCaps()
        return modified
    }
    
    public func monospacedDigit() -> Self {
        var modified = self
        modified.font = modified.font.monospacedDigit()
        return modified
    }
    
    public func weight(_ weight: Font.Weight) -> Self {
        var modified = self
        modified.font = modified.font.weight(weight)
        return modified
    }
    
    public func bold() -> Self {
        var modified = self
        modified.font = modified.font.bold()
        return modified
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    public func monospaced() -> Self {
        var modified = self
        modified.font = modified.font.monospaced()
        return modified
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public func leading(_ leading: Font.Leading) -> Self {
        var modified = self
        modified.font = modified.font.leading(leading)
        return modified
    }
}

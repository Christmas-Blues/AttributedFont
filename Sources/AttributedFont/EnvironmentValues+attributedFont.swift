import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
private struct AttributedFontKey: EnvironmentKey {
    
    static let defaultValue: AttributedFont? = nil
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    
    public var attributedFont: AttributedFont? {
        get { self[AttributedFontKey.self] }
        set { self[AttributedFontKey.self] = newValue }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    
    public func attributedFont(_ attributedFont: AttributedFont?) -> some View {
        return self.environment(\.attributedFont, attributedFont)
    }
}

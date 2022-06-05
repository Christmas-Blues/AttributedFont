import CoreText

@available(iOS 3.2, macOS 10.5, tvOS 9.0, watchOS 2.0, *)
public func CTFontGetLineHeight(_ font: CTFont) -> CGFloat {
    return CTFontGetAscent(font) + CTFontGetDescent(font) + CTFontGetLeading(font)
}

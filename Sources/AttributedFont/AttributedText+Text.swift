import SwiftUI

// MARK: Creating a Text View from a String

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedText {
    
    public init(_ key: LocalizedStringKey, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil) {
        self.init(text: Text(key, tableName: tableName, bundle: bundle, comment: comment))
    }
    
    @inlinable public init(verbatim content: String) {
        self.init(text: Text(verbatim: content))
    }
    
    @_disfavoredOverload public init<S: StringProtocol>(_ content: S) {
        self.init(text: Text(content))
    }
}

// MARK: Creating a Text View from an Attributed String

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AttributedText {
    
    public init(_ attributedContent: AttributedString) {
        self.init(text: Text(attributedContent))
    }
}

// MARK: Creating a Text View for a Date

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension AttributedText {
    
    public init(_ dates: ClosedRange<Date>) {
        self.init(text: Text(dates))
    }
    
    public init(_ interval: DateInterval) {
        self.init(text: Text(interval))
    }
    
    public init(_ date: Date, style: Text.DateStyle) {
        self.init(text: Text(date, style: style))
    }
}

// MARK: Creating a Text View with Formatting

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AttributedText {
    
    public init<F: FormatStyle>(_ input: F.FormatInput, format: F) where F.FormatInput : Equatable, F.FormatOutput == String {
        self.init(text: Text(input, format: format))
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension AttributedText {
    
    public init<Subject: ReferenceConvertible>(_ subject: Subject, formatter: Formatter) {
        self.init(text: Text(subject, formatter: formatter))
    }
    
    public init<Subject: NSObject>(_ subject: Subject, formatter: Formatter) {
        self.init(text: Text(subject, formatter: formatter))
    }
}

// MARK: Creating a Text View from an Image

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension AttributedText {
    
    public init(_ image: Image) {
        self.init(text: Text(image))
    }
}

// MARK: Choosing a Font

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedText {
    
    public func attributedFont(_ attributedFont: AttributedFont?) -> Self {
        var modified = self
        modified.text = text
            .font(attributedFont?.font)
            .kerning(attributedFont?.attributes.kerning ?? 0)
        modified.modifiedAttributedFont = attributedFont
        return modified
    }
    
    public func font(_ font: Font?) -> Self {
        var modified = self
        modified.text = text.font(font)
        return modified
    }
    
    public func fontWeight(_ weight: Font.Weight?) -> Self {
        var modified = self
        modified.text = text.fontWeight(weight)
        return modified
    }
}

// MARK: Styling the View’s Text

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedText {
    
    public func foregroundColor(_ color: Color?) -> Self {
        var modified = self
        modified.text = text.foregroundColor(color)
        return modified
    }
    
    public func bold() -> Self {
        var modified = self
        modified.text = text.bold()
        return modified
    }
    
    public func italic() -> Self {
        var modified = self
        modified.text = text.italic()
        return modified
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    public func monospacedDigit() -> Self {
        var modified = self
        modified.text = text.monospacedDigit()
        return modified
    }
    
    public func strikethrough(_ active: Bool = true, color: Color? = nil) -> Self {
        var modified = self
        modified.text = text.strikethrough(active, color: color)
        return modified
    }
    
    public func underline(_ active: Bool = true, color: Color? = nil) -> Self {
        var modified = self
        modified.text = text.underline(active, color: color)
        return modified
    }
    
    public func kerning(_ kerning: CGFloat) -> Self {
        var modified = self
        modified.text = text.kerning(kerning)
        return modified
    }
    
    public func tracking(_ tracking: CGFloat) -> Self {
        var modified = self
        modified.text = text.tracking(tracking)
        return modified
    }
    
    public func baselineOffset(_ baselineOffset: CGFloat) -> Self {
        var modified = self
        modified.text = text.baselineOffset(baselineOffset)
        return modified
    }
}

// MARK: Configuring VoiceOver

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AttributedText {
    
    public func speechAlwaysIncludesPunctuation(_ value: Bool = true) -> Self {
        var modified = self
        modified.text = text.speechAlwaysIncludesPunctuation(value)
        return modified
    }
    
    public func speechSpellsOutCharacters(_ value: Bool = true) -> Self {
        var modified = self
        modified.text = text.speechSpellsOutCharacters(value)
        return modified
    }
    
    public func speechAdjustedPitch(_ value: Double) -> Self {
        var modified = self
        modified.text = text.speechAdjustedPitch(value)
        return modified
    }
    
    public func speechAnnouncementsQueued(_ value: Bool = true) -> Self {
        var modified = self
        modified.text = text.speechAnnouncementsQueued(value)
        return modified
    }
}

// MARK: Providing Accessibility Information

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension AttributedText {
    public func accessibilityTextContentType(_ value: AccessibilityTextContentType) -> Self {
        var modified = self
        modified.text = text.accessibilityTextContentType(value)
        return modified
    }
    
    public func accessibilityHeading(_ level: AccessibilityHeadingLevel) -> Self {
        var modified = self
        modified.text = text.accessibilityHeading(level)
        return modified
    }
    
    public func accessibilityLabel(_ label: Text) -> Self {
        var modified = self
        modified.text = text.accessibilityLabel(label)
        return modified
    }
    
    public func accessibilityLabel(_ labelKey: LocalizedStringKey) -> Self {
        var modified = self
        modified.text = text.accessibilityLabel(labelKey)
        return modified
    }
    
    public func accessibilityLabel<S: StringProtocol>(_ label: S) -> Self {
        var modified = self
        modified.text = text.accessibilityLabel(label)
        return modified
    }
}

// MARK: Combining Text Views

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedText {
    
    public static func concatenate(_ views: [AttributedText], attributedFont: AttributedFont) -> Self {
        let text = views.map(\.text).reduce(Text(verbatim: ""), +)
        var attributedText: AttributedText = .init(text: text)
        attributedText.modifiedAttributedFont = attributedFont
        return attributedText
    }
    
    public static func concatenate(_ views: AttributedText..., attributedFont: AttributedFont) -> Self {
        return Self.concatenate(views, attributedFont: attributedFont)
    }
}

// MARK: Comparing Text Views

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AttributedText: Equatable {
    
    public static func == (lhs: AttributedText, rhs: AttributedText) -> Bool {
        return lhs.text == rhs.text
    }
}

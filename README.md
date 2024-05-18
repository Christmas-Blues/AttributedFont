# AttributedFont

[![Build](https://github.com/riiid/AttributedFont/actions/workflows/build.yml/badge.svg)](https://github.com/riiid/AttributedFont/actions/workflows/build.yml)

SwiftUI에서 `Font`에 어트리뷰트를 설정하는 획기적인 방법.

```swift
import SwiftUI
import AttributedFont

let font = AttributedFont
    .custom(
        "Noto Sans KR",
        fixedSize: 17,
        attributes: .init(
              kerning: -0.2,
              lineHeightMultiple: 1.5
        )
    )
```

## 목차
- [동기](#동기)
- [기능](#기능)
- [사용](#사용)
    - [폰트 생성하기](#폰트-생성하기)
    - [폰트 적용하기](#폰트-적용하기)
    - [텍스트 조작하기](#텍스트-조작하기)
    - [텍스트 결합하기](#텍스트-결합하기)
- [요구 사항](#요구-사항)
- [설치](#설치)
    - [Swift Package Manager](#swift-package-manager)
    - [Xcode](#xcode)
- [기여하기](#기여하기)
- [라이선스](#라이선스)

## 동기

타이포그래피 시스템을 정의할 때, 자간과 줄 높이를 폰트 기본값 대신 사용자 설정 값으로 직접 조정해 사용하는 경우가 종종 있습니다. 산타의 타이포그래피 시스템에서도 Spoqa Han Sans를 자간과 줄 높이를 조정해 사용하고 있는데요. SwiftUI에서는 자간 조정을 위해 [`kerning(_:)`](https://developer.apple.com/documentation/swiftui/text/kerning(_:)), [`tracking(_:)`](https://developer.apple.com/documentation/swiftui/text/tracking(_:)) 등의 모디파이어를 제공하지만, 이 모디파이어들은 `Text` 뷰에만 적용이 가능하다는 한계가 있습니다. 다시 말해, `VStack`이나 `ButtonStyleConfiguration.Label` 같이 `Text`가 아닌 뷰에는 커닝과 트래킹 값을 적용할 수 없습니다.

이 같은 한계는 [`@Environment`](https://developer.apple.com/documentation/swiftui/environment)를 사용해 값을 전달하는 [`font(_:)`](https://developer.apple.com/documentation/swiftui/form/font(_:)) 모디파이어와 다르게, `kerning(_:)`과 `tracking(_:)` 모디파이어의 경우 [`Text`](https://developer.apple.com/documentation/swiftui/text) 인스턴스를 직접 수정하는 방식으로 작동하기 때문에 발생하는데요. 반대로 생각해 본다면, 커닝과 트래킹 값도 `@Environment`를 통해 전달할 수 있게 된다면 앞에서 말씀드렸던 문제를 해결할 수 있다는 결론에 이르게 됩니다.

**`AttributedFont`는 SwiftUI의 [`Font`](https://developer.apple.com/documentation/swiftui/font)를 확장하여 `kerning`, `tracking` 등의 어트리뷰트를 `@Environment`를 통해 전달함으로써 `Text`가 아닌 뷰에도 커닝과 트래킹 값을 적용할 수 있도록 합니다. 여기에 더해, `lineHeightMultiple` 어트리뷰트를 지원함으로써 SwiftUI의 [`lineSpacing(_:)`](https://developer.apple.com/documentation/swiftui/view/linespacing(_:)) 모디파이어로는 완전히 달성할 수 없었던 줄 높이 값 변경이 가능하록 도와줍니다.**

## 기능

- 폰트 인스턴스에 커닝과 트래킹 값을 지정할 수 있습니다.
- 폰트 인스턴스에 줄 높이 배수 값을 지정할 수 있습니다.

## 사용

### 폰트 생성하기

`Font` 인스턴스를 생성하는 것과 유사하게, `AttributedFont`도 `custom(_:fixedSize:attributes:)` 메소드를 사용하여 인스턴스를 생성합니다.

```swift
AttributedFont.custom("Noto Sans KR", fixedSize: 17, attributes: nil)
```

`attributes` 파라미터를 통해 폰트 인스턴스에 어트리뷰트를 설정할 수 있습니다. 현재 `AttributedFont.Attributes`는 `kerning`, `tracking`, `lineHeightMultiple`의 세 가지 값을 지원합니다.

```swift
AttributedFont
    .custom(
        "Noto Sans KR",
        fixedSize: 17,
        attributes: .init(
            kerning: -0.2,
            lineHeightMultiple: 1.5
        )
    )
```

`tracking`과 `kerning` 값을 동시에 지정할 경우, [SwiftUI에서의 기본 동작](https://developer.apple.com/documentation/swiftui/text/kerning(_:))과 마찬가지로 `tracking` 값만 적용되며 `kerning` 값은 무시됩니다.

```swift
AttributedFont
    .custom(
        "Noto Sans KR",
        fixedSize: 17,
        attributes: .init(
            kerning: 0, // tracking과 함께 지정된 kerning 값은 무시됩니다.
            tracking: -0.2,
            lineHeightMultiple: 1.5
        )
    )
```

### 폰트 적용하기

`AttributedFont`를 사용하기 위해서는 `AttributedText`를 함께 사용해야 합니다. `AttributedText`는 `AttributedFont`를 `@Environment`로 받을 수 있도록 `Text`를 확장시킨 `View`입니다.

`AttributedText` 또는 `AttributedText`를 임베딩하고 있는 뷰에 `attributedFont(_:)` 모디파이어를 사용하여 폰트 어트리뷰트를 적용합니다. `AttributedFont`는 `AttributedText`에만 적용되어 보여집니다.

```swift
AttributedText("Hello, world!")
    .attributedFont(
        .custom(
            "Noto Sans KR",
            fixedSize: 17,
            attributes: .init(
                kerning: -0.2,
                lineHeightMultiple: 1.5
            )
        )
    )
```

자주 사용하는 폰트 인스턴스의 경우, `AttributedFont`의 `extension`으로 정적 프로퍼티를 정의하면 간편하게 사용할 수 있습니다.

```swift
extension AttributedFont {
    static let body: Self = .custom(
        "Noto Sans KR",
        fixedSize: 17,
        attributes: .init(
            kerning: -0.2,
            lineHeightMultiple: 1.5
        )
    )
}

AttributedText("Hello, world!")
    .attributedFont(.body)
```

### 텍스트 조작하기

`AttributedFont`와 `AttributedText`는 `Font`와 `Text`에서 사용 가능한 대부분의 모디파이어와 연산자를 지원합니다.

<details>
<summary><code>AttributedFont</code></summary>

```swift
struct AttributedFont: Equatable, Hashable {

    // Creating Custom Fonts
    static func custom(_ name: String, fixedSize: CGFloat, attributes: Attributes) -> Self

    // Styling a Font
    func italic() -> Self
    func smallCaps() -> Self
    func lowercaseSmallCaps() -> Self
    func uppercaseSmallCaps() -> Self
    func monospacedDigit() -> Self
    func weight(_ weight: Font.Weight) -> Self
    func bold() -> Self
    func monospaced() -> Self
    func leading(_ leading: Font.Leading) -> Self
}
```
</details>

<details>
<summary><code>AttributedText</code></summary>

```swift
struct AttributedText: View, Equatable {

    // Creating a Text View from a String
    init(_ key: LocalizedStringKey, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil)
    @inlinable init(verbatim content: String)
    init<S: StringProtocol>(_ content: S)

    // Creating a Text View from an Attributed String
    init(_ attributedContent: AttributedString)

    // Creating a Text View for a Date
    init(_ dates: ClosedRange<Date>)
    init(_ interval: DateInterval)
    init(_ date: Date, style: Text.DateStyle)

    // Creating a Text View with Formatting
    init<F: FormatStyle>(_ input: F.FormatInput, format: F) where F.FormatInput: Equatable, F.FormatOutput == String
    init<Subject: ReferenceConvertible>(_ subject: Subject, formatter: Formatter)
    init<Subject: NSObject>(_ subject: Subject, formatter: Formatter)

    // Creating a Text View from an Image
    init(_ image: Image)

    // Choosing a Font
    func attributedFont(_ attributedFont: AttributedFont?) -> Self
    func font(_ font: Font?) -> Self
    func fontWeight(_ weight: Font.Weight?) -> Self

    // Styling the View’s Text
    func foregroundColor(_ color: Color?) -> Self
    func bold() -> Self
    func italic() -> Self
    func monospacedDigit() -> Self
    func strikethrough(_ active: Bool = true, color: Color? = nil) -> Self
    func underline(_ active: Bool = true, color: Color? = nil) -> Self
    func kerning(_ kerning: CGFloat) -> Self
    func tracking(_ tracking: CGFloat) -> Self
    func baselineOffset(_ baselineOffset: CGFloat) -> Self

    // Configuring VoiceOver
    func speechAlwaysIncludesPunctuation(_ value: Bool = true) -> Self
    func speechSpellsOutCharacters(_ value: Bool = true) -> Self
    func speechAdjustedPitch(_ value: Double) -> Self
    func speechAnnouncementsQueued(_ value: Bool = true) -> Self

    // Providing Accessibility Information
    func accessibilityTextContentType(_ value: AccessibilityTextContentType) -> Self
    func accessibilityHeading(_ level: AccessibilityHeadingLevel) -> Self
    func accessibilityLabel(_ label: Text) -> Self
    func accessibilityLabel(_ labelKey: LocalizedStringKey) -> Self
    func accessibilityLabel<S: StringProtocol>(_ label: S) -> Self

    // Combining Text Views
    static func concatenate(_ views: [AttributedText], attributedFont: AttributedFont) -> Self
    static func concatenate(_ views: AttributedText..., attributedFont: AttributedFont) -> Self
}
```
</details>

### 텍스트 결합하기

`Text`의 [`+`](https://developer.apple.com/documentation/swiftui/text/+(_:_:)) 연산을 지원하기 위해, `AttributedText`에서도 `concatenate(_:attributedFont:)` 메소드를 제공하여 텍스트 결합을 지원합니다.

```swift
AttributedText.concatenate(
    AttributedText("Hello,\n").attributedFont(.subheadline).foregroundColor(.secondary),
    AttributedText("world!").attributedFont(.headline).foregroundColor(.primary),
    attributedFont: .headline
)
```

[`lineSpacing(_:)`](https://developer.apple.com/documentation/swiftui/view/linespacing(_:))과 상하단 [`padding(_:_:)`](https://developer.apple.com/documentation/swiftui/view/padding(_:_:))을 사용하여 `lineHeightMultiple`을 적용하는 `AttributedText`의 특성으로 인해, 여러 개의 `AttributedText`를 결합할 때에는 개별적으로 설정된 `lineHeightMultiple` 값이 무시되며, `concatenate(_:attributedFont:)` 메소드의 마지막 파라미터로 전달된 `attributedFont`의 `lineHeightMultiple` 값을 전체 적용합니다.

## 요구 사항

- Swift 5.3+
- Xcode 12.0+
- iOS 14.0+
- Mac Catalyst 14.0+
- macOS 11.0+
- tvOS 14.0+
- watchOS 7.0+

## 설치

### Swift Package Manager

[`Package.swift`](https://developer.apple.com/documentation/swift_packages/package) 파일의 `dependencies`에 아래 라인을 추가합니다.

```swift
.package(url: "https://github.com/riiid/AttributedFont.git", .upToNextMajor(from: "1.0.0"))
```

그 다음, `AttributedFont`를 타겟의 의존성으로 추가합니다.

```swift
.target(name: "MyTarget", dependencies: ["AttributedFont"])
```

완성된 디스크립션은 아래와 같습니다.

```swift
// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/riiid/AttributedFont.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(name: "MyTarget", dependencies: ["AttributedFont"])
    ]
)
```

### Xcode

File > Swift Packages > Add Package Dependency를 선택한 다음, 아래의 URL을 입력합니다.

```
https://github.com/riiid/AttributedFont.git
```

자세한 내용은 [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)을 참조하세요.

## 기여하기

저희는 모든 종류의 기여를 환영하며, 기여해 주시는 분들의 모든 의견을 존중합니다. 간단한 기능 추가, 버그 픽스, 오타 수정 등이라도 주저하지 말고 [이슈](https://github.com/riiid/AttributedFont/issues)나 [PR](https://github.com/riiid/AttributedFont/pulls)을 생성하여 의견을 제기해 주세요.

#### 메인테이너

- **김동규** ([**@stleamist**](https://github.com/stleamist))

#### 도움을 주신 분들

- **이민호** ([**@tisohjung**](https://github.com/tisohjung)): 초기 버전에서 `lineHeightMultiple`이 제대로 적용되지 않는 문제를 발견하고 수정해주셨습니다.

## 라이선스

`AttributedFont`는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](/LICENSE)를 참조하세요.

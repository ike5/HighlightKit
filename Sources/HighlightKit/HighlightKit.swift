// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Foundation

public struct HighlightKit {
    private let rules: [SyntaxRule]

    public init(language: Language, theme: SyntaxTheme) {
        self.rules = LanguageRules.rules(for: language, theme: theme)
    }

    public func highlight(code: String) -> AttributedString {
        var attributed = AttributedString(code)
        for rule in rules {
            if let regex = try? NSRegularExpression(pattern: rule.pattern, options: rule.regexOptions) {
                let nsRange = NSRange(code.startIndex..., in: code)
                for match in regex.matches(in: code, options: [], range: nsRange) {
                    if let stringRange = Range(match.range, in: code),
                       let attributedRange = Range(stringRange, in: attributed) {
                        attributed[attributedRange].mergeAttributes(rule.attributes)
                    }
                }
            }
        }
        return attributed
    }
}

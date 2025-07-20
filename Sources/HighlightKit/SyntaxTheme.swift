//
//  SyntaxTheme.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//


import SwiftUI

public struct SyntaxTheme: @unchecked Sendable {
    public let keyword: Color
    public let string: Color
    public let comment: Color
    public let number: Color
    public let plain: Color

    public init(keyword: Color, string: Color, comment: Color, number: Color, plain: Color = .primary) {
        self.keyword = keyword
        self.string = string
        self.comment = comment
        self.number = number
        self.plain = plain
    }

    public static func system(for scheme: ColorScheme) -> SyntaxTheme {
        switch scheme {
        case .dark:
            return .darkDefault
        case .light:
            return .lightDefault
        @unknown default:
            return .lightDefault
        }
    }

    public static let darkDefault = SyntaxTheme(
        keyword: .blue,
        string: .orange,
        comment: .green,
        number: .purple,
        plain: .white
    )

    public static let lightDefault = SyntaxTheme(
        keyword: .blue,
        string: .red,
        comment: .green,
        number: .purple,
        plain: .black
    )
}

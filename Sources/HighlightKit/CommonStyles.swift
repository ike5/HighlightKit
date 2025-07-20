//
//  CommonStyles.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//


import SwiftUI

public struct CommonStyles {
    public static func rules(for theme: SyntaxTheme) -> [String: AttributeContainer] {
        return [
            "keyword": AttributeContainer.foregroundColor(theme.keyword),
            "string": AttributeContainer.foregroundColor(theme.string),
            "comment": AttributeContainer.foregroundColor(theme.comment),
            "number": AttributeContainer.foregroundColor(theme.number)
        ]
    }
}

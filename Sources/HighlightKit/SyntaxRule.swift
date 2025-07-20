//
//  SyntaxRule.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//


import Foundation
import SwiftUI

public struct SyntaxRule {
    public let pattern: String
    public let regexOptions: NSRegularExpression.Options
    public let attributes: AttributeContainer

    public init(pattern: String, options: NSRegularExpression.Options = [], attributes: AttributeContainer) {
        self.pattern = pattern
        self.regexOptions = options
        self.attributes = attributes
    }
}

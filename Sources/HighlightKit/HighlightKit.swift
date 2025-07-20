import Foundation
import SwiftUI

// HighlightKitAPI.swift


public enum HighlightKitAPI {
    public static func highlight(_ code: String, colorScheme: ColorScheme = .light) -> AttributedString {
        let language = LanguageDetector.detectLanguage(for: code) ?? .swift
        let theme = SyntaxTheme.system(for: colorScheme)
        let rules = LanguageRules.rules(for: language, theme: theme)

        var attributed = AttributedString(code)
        for rule in rules {
            if let regex = try? NSRegularExpression(pattern: rule.pattern, options: rule.regexOptions) {
                let nsrange = NSRange(code.startIndex..<code.endIndex, in: code)
                let matches = regex.matches(in: code, options: [], range: nsrange)
                for match in matches {
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

// Usage:
// Text(HighlightKitAPI.highlight(codeString))
//
//  Created by Ike Maldonado on 7/19/25.
//




//
//  CommonStyles.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//

public enum TokenType: String {
    case keyword
    case type
    case function
    case variable
    case constant
    case `operator`
    case punctuation
    case string
    case number
    case comment
}

public struct CommonStyles {
    public static func style(for token: TokenType, theme: SyntaxTheme) -> AttributeContainer {
        switch token {
        case .keyword:
            return AttributeContainer.foregroundColor(theme.keyword)
        case .type:
            return AttributeContainer.foregroundColor(.teal)
        case .function:
            return AttributeContainer.foregroundColor(.pink)
        case .variable:
            return AttributeContainer.foregroundColor(.primary)
        case .constant:
            return AttributeContainer.foregroundColor(.purple)
        case .operator:
            return AttributeContainer.foregroundColor(.gray)
        case .punctuation:
            return AttributeContainer.foregroundColor(.gray.opacity(0.6))
        case .string:
            return AttributeContainer.foregroundColor(theme.string)
        case .number:
            return AttributeContainer.foregroundColor(theme.number)
        case .comment:
            return AttributeContainer.foregroundColor(theme.comment)
        }
    }
}

//
//  Language.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//

public enum Language {
    case swift, python, javascript, typescript, java, csharp, json, html, css, cpp, c, go, kotlin, ruby, php, bash, sql
}

//
//  File.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//


public struct LanguageDetector {
    public static func detectLanguage(for code: String) -> Language? {
        let lowercased = code.lowercased()

        let checks: [(Language, [String])] = [
            (.swift, ["import swiftui", "struct ", "func ", "let ", "var "]),
            (.python, ["def ", "import ", "elif", "print(", "#"]),
            (.javascript, ["function ", "const ", "let ", "console.log", "=>"]),
            (.typescript, ["interface ", "type ", "as ", ": string", "=>"]),
            (.csharp, ["using ", "namespace ", "class ", "void ", "//"]),
            (.java, ["public class", "System.out.println", "static void"]),
            (.json, ["{", "}", ":", "\""]),
            (.html, ["<html", "<body", "<div", "</"]),
            (.css, ["color:", "background:", "font-family:"]),
            (.cpp, ["#include", "std::", "->"]),
            (.c, ["#include", "int main(", "printf"]),
            (.go, ["package main", "func main(", "import"]),
            (.kotlin, ["fun ", "val ", "var ", "when"]),
            (.ruby, ["def ", "end", "puts"]),
            (.php, ["<?php", "echo", "$"]),
            (.bash, ["#!/bin/bash", "echo ", "fi", ";;"]),
            (.sql, ["select ", "from ", "where ", "insert ", "join"])
        ]

        for (lang, keywords) in checks {
            if keywords.contains(where: { lowercased.contains($0) }) {
                return lang
            }
        }

        return nil
    }
}

//
//  LanguageRules.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//


public enum LanguageRules {
    public static func rules(for language: Language, theme: SyntaxTheme) -> [SyntaxRule] {
        switch language {
        case .swift:
            return [
                SyntaxRule(pattern: #"(?<!\w)(let|var|func|if|else|for|while|return|class|struct|enum|import|guard|defer|in|where|as|is|try|catch|throw)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"\b(Bool|Int|String|Double|Float|Void|Any|Self|Self.Type)\b"#, attributes: CommonStyles.style(for: .type, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"//.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #"\b(true|false|nil)\b"#, attributes: CommonStyles.style(for: .constant, theme: theme)),
                SyntaxRule(pattern: #"[+\-*/=<>!&|^%~]+"#, attributes: CommonStyles.style(for: .operator, theme: theme)),
                SyntaxRule(pattern: #"[{}()\[\];:,\.]"#, attributes: CommonStyles.style(for: .punctuation, theme: theme)),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: CommonStyles.style(for: .number, theme: theme)),
                // Class and struct names after keywords
                SyntaxRule(pattern: #"(?<=class\s|struct\s)[A-Za-z_]\w*"#, attributes: CommonStyles.style(for: .type, theme: theme)),
                
                // Function names after func keyword
                SyntaxRule(pattern: #"(?<=func\s)[A-Za-z_]\w*"#, attributes: CommonStyles.style(for: .function, theme: theme)),
                
                // Parameters inside function parentheses (simplified)
                // Highlight parameter names as variables
                SyntaxRule(pattern: #"(?<=func\s\w+\s*\()[^)]*(?=\))"#, attributes: CommonStyles.style(for: .variable, theme: theme)),
            ]
        case .python:
            return [
                SyntaxRule(pattern: #"(?<!\w)(def|import|from|as|if|elif|else|for|while|return|class|try|except|with|lambda|pass|break|continue|yield|raise|assert|global|nonlocal|del|async|await)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"\b(bool|int|float|str|list|dict|set|tuple|None|True|False)\b"#, attributes: CommonStyles.style(for: .type, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""|'([^'\\]|\\.)*'"#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"#.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #"\b(True|False|None)\b"#, attributes: CommonStyles.style(for: .constant, theme: theme)),
                SyntaxRule(pattern: #"[+\-*/=<>!&|^%~]+"#, attributes: CommonStyles.style(for: .operator, theme: theme)),
                SyntaxRule(pattern: #"[{}()\[\];:,\.]"#, attributes: CommonStyles.style(for: .punctuation, theme: theme)),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: CommonStyles.style(for: .number, theme: theme))
            ]
        case .javascript, .typescript:
            return [
                SyntaxRule(pattern: #"(?<!\w)(const|let|var|function|if|else|for|while|return|import|export|class|new|await|async)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*"|'([^'\\]|\\.)*"([^\\]|\\.)*`"#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"//.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: CommonStyles.style(for: .number, theme: theme))
            ]
        case .java:
            return [
                SyntaxRule(pattern: #"(?<!\w)(public|private|protected|class|static|void|int|float|double|new|return|if|else|for|while|try|catch)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"//.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: CommonStyles.style(for: .number, theme: theme))
            ]
        case .csharp:
            return [
                SyntaxRule(pattern: #"(?<!\w)(using|namespace|class|public|private|protected|static|void|int|string|float|double|return)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"\bConsole\b"#, attributes: CommonStyles.style(for: .type, theme: theme)),
                SyntaxRule(pattern: #"\bWriteLine\b(?=\()"#, attributes: CommonStyles.style(for: .function, theme: theme)),
                SyntaxRule(pattern: #"\btrue\b|\bfalse\b|\bnull\b"#, attributes: CommonStyles.style(for: .constant, theme: theme)),
                SyntaxRule(pattern: #"[+\-*/=<>!]+"#, attributes: CommonStyles.style(for: .operator, theme: theme)),
                SyntaxRule(pattern: #"[{}();:,]"#, attributes: CommonStyles.style(for: .punctuation, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"//.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: CommonStyles.style(for: .number, theme: theme))
            ]
        case .json:
            return [
                SyntaxRule(pattern: #""([^"]*)"\s*:"# , attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #":\s*("[^"]*"|\d+|true|false|null)"#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: CommonStyles.style(for: .number, theme: theme))
            ]
        case .html:
            return [
                SyntaxRule(pattern: #"<[^>]+>"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"(?<=>)[^<]+"#, attributes: CommonStyles.style(for: .string, theme: theme))
            ]
        case .css:
            return [
                SyntaxRule(pattern: #"[a-zA-Z-]+\s*:"# , attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #":\s*[^;]+;"#, attributes: CommonStyles.style(for: .string, theme: theme))
            ]
        case .cpp, .c:
            return [
                SyntaxRule(pattern: #"(?<!\w)(#include|int|void|float|double|return|if|else|for|while)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"//.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #"".*?""#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: CommonStyles.style(for: .number, theme: theme))
            ]
        case .go:
            return [
                SyntaxRule(pattern: #"(?<!\w)(package|import|func|var|const|if|else|for|return|struct|interface)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"//.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: CommonStyles.style(for: .string, theme: theme))
            ]
        case .kotlin:
            return [
                SyntaxRule(pattern: #"(?<!\w)(fun|val|var|if|else|when|class|object|import|package|return)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"//.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: CommonStyles.style(for: .string, theme: theme))
            ]
        case .ruby:
            return [
                SyntaxRule(pattern: #"(?<!\w)(def|class|module|if|elsif|else|end|require|include|puts)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"#[^\n]*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""|'([^'\\]|\\.)*'"#, attributes: CommonStyles.style(for: .string, theme: theme))
            ]
        case .php:
            return [
                SyntaxRule(pattern: #"(?<!\w)(function|echo|if|else|while|for|foreach|return|class)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"//.*|#.*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: CommonStyles.style(for: .string, theme: theme))
            ]
        case .bash:
            return [
                SyntaxRule(pattern: #"(?<!\w)(if|then|else|fi|for|while|do|done|echo)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"#[^\n]*"#, attributes: CommonStyles.style(for: .comment, theme: theme)),
                SyntaxRule(pattern: #""[^"]*""#, attributes: CommonStyles.style(for: .string, theme: theme))
            ]
        case .sql:
            return [
                SyntaxRule(pattern: #"(?<!\w)(SELECT|FROM|WHERE|INSERT|INTO|VALUES|UPDATE|DELETE|JOIN|ON|AS|AND|OR)(?!\w)"#, attributes: CommonStyles.style(for: .keyword, theme: theme)),
                SyntaxRule(pattern: #"'([^']*)'"#, attributes: CommonStyles.style(for: .string, theme: theme)),
                SyntaxRule(pattern: #"--.*"#, attributes: CommonStyles.style(for: .comment, theme: theme))
            ]
        }
    }
}

//
//  SyntaxRule.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//


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

//
//  SyntaxTheme.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//

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



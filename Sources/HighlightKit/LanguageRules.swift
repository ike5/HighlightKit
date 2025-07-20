//
//  LanguageRules.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//


import SwiftUI

public enum LanguageRules {
    public static func rules(for language: Language, theme: SyntaxTheme) -> [SyntaxRule] {
        let styles = CommonStyles.rules(for: theme)

        switch language {
        case .swift:
            return [
                SyntaxRule(pattern: #"(?<!\w)(let|var|func|if|else|for|while|return|class|struct|enum|import)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"//.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: styles["number"]!)
            ]
        case .python:
            return [
                SyntaxRule(pattern: #"(?<!\w)(def|import|from|as|if|elif|else|for|while|return|class|try|except|with|lambda)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""|'([^'\\]|\\.)*'"#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"#.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: styles["number"]!)
            ]
        case .javascript, .typescript:
            return [
                SyntaxRule(pattern: #"(?<!\w)(const|let|var|function|if|else|for|while|return|import|export|class|new|await|async)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*"|'([^'\\]|\\.)*"`([^`\\]|\\.)*`"#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"//.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: styles["number"]!)
            ]
        case .java:
            return [
                SyntaxRule(pattern: #"(?<!\w)(public|private|protected|class|static|void|int|float|double|new|return|if|else|for|while|try|catch)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"//.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: styles["number"]!)
            ]
        case .csharp:
            return [
                SyntaxRule(pattern: #"(?<!\w)(using|namespace|class|public|private|protected|static|void|int|string|float|double|return)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"//.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: styles["number"]!)
            ]
        case .json:
            return [
                SyntaxRule(pattern: #""([^"]*)"\s*:"# , attributes: styles["keyword"]!),
                SyntaxRule(pattern: #":\s*("[^"]*"|\d+|true|false|null)"#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: styles["number"]!)
            ]
        case .html:
            return [
                SyntaxRule(pattern: #"<[^>]+>"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"(?<=>)[^<]+"#, attributes: styles["string"]!)
            ]
        case .css:
            return [
                SyntaxRule(pattern: #"[a-zA-Z-]+\s*:"# , attributes: styles["keyword"]!),
                SyntaxRule(pattern: #":\s*[^;]+;"#, attributes: styles["string"]!)
            ]
        case .cpp, .c:
            return [
                SyntaxRule(pattern: #"(?<!\w)(#include|int|void|float|double|return|if|else|for|while)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"//.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #"".*?""#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"\b\d+(\.\d+)?\b"#, attributes: styles["number"]!)
            ]
        case .go:
            return [
                SyntaxRule(pattern: #"(?<!\w)(package|import|func|var|const|if|else|for|return|struct|interface)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"//.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: styles["string"]!)
            ]
        case .kotlin:
            return [
                SyntaxRule(pattern: #"(?<!\w)(fun|val|var|if|else|when|class|object|import|package|return)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"//.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: styles["string"]!)
            ]
        case .ruby:
            return [
                SyntaxRule(pattern: #"(?<!\w)(def|class|module|if|elsif|else|end|require|include|puts)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"#[^\n]*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""|'([^'\\]|\\.)*'"#, attributes: styles["string"]!)
            ]
        case .php:
            return [
                SyntaxRule(pattern: #"(?<!\w)(function|echo|if|else|while|for|foreach|return|class)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"//.*|#.*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #""([^"\\]|\\.)*""#, attributes: styles["string"]!)
            ]
        case .bash:
            return [
                SyntaxRule(pattern: #"(?<!\w)(if|then|else|fi|for|while|do|done|echo)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"#[^\n]*"#, attributes: styles["comment"]!),
                SyntaxRule(pattern: #""[^"]*""#, attributes: styles["string"]!)
            ]
        case .sql:
            return [
                SyntaxRule(pattern: #"(?<!\w)(SELECT|FROM|WHERE|INSERT|INTO|VALUES|UPDATE|DELETE|JOIN|ON|AS|AND|OR)(?!\w)"#, attributes: styles["keyword"]!),
                SyntaxRule(pattern: #"'([^']*)'"#, attributes: styles["string"]!),
                SyntaxRule(pattern: #"--.*"#, attributes: styles["comment"]!)
            ]
        }
    }
}
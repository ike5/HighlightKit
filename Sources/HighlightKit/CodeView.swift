//
//  CodeView.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//

import SwiftUI

struct CodeView: View {
    let code: String
    let language: Language
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        let theme = SyntaxTheme.system(for: colorScheme)
        let highlighter = HighlightKit(language: language, theme: theme)

        ScrollView(.vertical) {
            Text(highlighter.highlight(code: code))
                .font(.system(.body, design: .monospaced))
                .padding()
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

#Preview {
    CodeView(code: """
    using System;

    class Program {
        static void Main() {
            Console.WriteLine("Hello, world!");
        }
    }
    """, language: .swift)
}

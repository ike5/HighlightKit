//
//  File.swift
//  HighlightKit
//
//  Created by Ike Maldonado on 7/19/25.
//

import Foundation

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

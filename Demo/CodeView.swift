//
//  CodeView.swift
//  Demo
//
//  Created by Purkylin King on 2024/3/13.
//

import libprisma
import SwiftUI

struct CodeView: View {
    let code: String
    let lang: String

    @State private var style = NSAttributedString()

    var body: some View {
        VStack {
            Text(AttributedString(style))
                .frame(maxWidth: .infinity, minHeight: 60, alignment: .topLeading)
                .padding(.top, 35)
                .padding(.horizontal, 12)
                .padding(.bottom, 6)
        }
        .background(Tailwind.Color.green100)
        .overlay {
            VStack {
                HStack {
                    Text(lang)
                    Spacer()
                    Button(action: {
                        UIPasteboard.general.string = code
                    }, label: {
                        Image(systemName: "doc.on.doc.fill")
                    })
                }
                .foregroundStyle(Tailwind.Color.green600)
                .padding(.horizontal, 12).padding(.vertical, 4)
                .background(Color.black.opacity(0.15))
                Spacer()
            }
            .font(.footnote).bold()
        }
        .overlay{
            HStack {
                Rectangle().fill(Tailwind.Color.green500).frame(width: 4)
                Spacer()
            }
            .clipShape(ContainerRelativeShape())
        }
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .padding(.horizontal, 8)
        .task {
            style = highlight(code: code, lang: lang)
        }
    }

    private func highlight(code: String, lang: String) -> NSAttributedString {
        let syntaxHighlighter = Syntaxer()!

        let font = UIFont.monospacedSystemFont(ofSize: 17, weight: .regular)
        let theme = SyntaxterTheme(dark: false, textColor: UIColor.black, textFont: font, italicFont: font, mediumFont: font)

        return syntaxHighlighter.syntax(code, language: lang, theme: theme)
    }
}


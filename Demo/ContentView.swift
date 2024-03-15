//
//  ContentView.swift
//  Demo
//
//  Created by Purkylin King on 2024/3/12.
//

import SwiftUI
import UIKit

struct ContentView: View {
    private let code = """
    import SwiftUI

    @main
    struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    """

    var body: some View {
        VStack {
            CodeView(code: code, lang: "swift")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}



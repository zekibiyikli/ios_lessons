//
//  ContentView.swift
//  FirstSwiftUI
//
//  Created by Zeki Mac on 1.04.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding()
            Text("Hello, world!")
                .font(.largeTitle)
                .foregroundStyle(.green)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

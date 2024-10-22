//
//  ContentView.swift
//  DesignTokens
//
//  Created by Gaetano Matonti on 22/10/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: .dimension(.medium)) {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.token(.textLink))
      
      Text("Hello, world!")
        .foregroundStyle(.token(.textPrimary))
    }
    .padding()
    .background()
    .backgroundStyle(.token(.backgroundBase))
  }
}

#Preview {
  ContentView()
}

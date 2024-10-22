//
//  ContentView.swift
//  DesignTokens
//
//  Created by Gaetano Matonti on 22/10/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color.token(.backgroundBase)
        .ignoresSafeArea()
      
      VStack(spacing: .token(dimension: .medium)) {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundStyle(.token(.textLink))
        
        Text("Hello, world!")
          .foregroundStyle(.token(.textPrimary))
      }
      .padding()
      .background(
        in: .rect(cornerRadius: .token(dimension: .small))
      )
      .backgroundStyle(
        .linearGradient(
          .token(.background),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      )
    }
  }
}

#Preview {
  ContentView()
}

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

      Text("Hello World! Check out [swift-design-tokens](https://github.com/gaetanomatonti/swift-design-tokens).")
        .foregroundStyle(.token(.textPrimary))
        .tint(.token(.textLink))
        .padding(.token(dimension: .medium))
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

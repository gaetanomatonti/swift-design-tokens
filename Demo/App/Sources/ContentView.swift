//
//  ContentView.swift
//  DesignTokens
//
//  Created by Gaetano Matonti on 22/10/24.
//

import SwiftUI

struct ContentView: View {
  @State private var isPressed = false

  var body: some View {
    ZStack {
      Color.token(.backgroundBase)
        .ignoresSafeArea()

      Button {
        
      } label: {
        Text("Hello World! Check out [swift-design-tokens](https://github.com/gaetanomatonti/swift-design-tokens).")
      }
      .buttonStyle(CardButtonStyle())
    }
  }
}

struct CardButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundStyle(.token(.textPrimary))
      .tint(.token(.textLink))
      .padding(.token(dimension: .medium))
      .background(.token(.backgroundContainer), in: .containerRelative)
      .shadow(configuration.isPressed ? .cardPressed : .cardDrop)
      .containerShape(.rect(cornerRadius: .token(dimension: .small)))
      .animation(.interactiveSpring, value: configuration.isPressed)
  }
}

#Preview {
  ContentView()
}

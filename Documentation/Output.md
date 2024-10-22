#  Output

The command line tool generates source code as the resulting output of the design tokens translation. 
To avoid conflicts with system types, and properties, `swift-design-tokens` also generates a set of APIs to facilitate the usage of the design tokens.

## Name spacing

To prevent naming conflicts between tokens, we preserve the name space (or token path) of the token, and use a prettified version of the token path as its name.

```json
{
  "black": {
    "$type": "color",
    "$value": "#000000"
  },
  "text" {
    "primary": {
      "$type": "color",
      "$value": "{black}"
    },
  }
}
```

For example, the generated source code output for the above color tokens will contain a property named `black` for the `black` color token, and `textPrimary` for the token at path `"text" / "primary"`. 

## Token Types

### Aliases

Alias tokens will always use the format of their referenced token's type, and will be formatted as a computed property.

### Colors

`swift-design-tokens` generates the `ColorToken` type, and extends it with static properties to access the tokens. 

```swift
extension ColorToken {
  static let textPrimary = ColorToken(...)
  ...
}
```

The tool does this to avoid conflicts with system-defined colors, like SwiftUI's `red`, `green`, etc. 
This means that all color tokens can only be accessed with a custom set of APIs.

The generated source code provides the `Color(token:)` initializer, together with a `.token(_:)` static function to access a color from the `ColorToken` extension.

```swift
var body: some View {
  Text("Hello World!")
    .foregroundStyle(.token(.textPrimary))
}
```

A similar set of APIs is available for UIKit as well.

### Dimensions and numbers

Similarly to color tokens, dimensions, and numbers, also have their custom type, and set of APIs.
However, because both values translates to a floating-point type, the APIs need to be more specific about the type of token we want to use.

For dimension tokens, we provide the `.token(dimension:)` static function, while number tokens can be accessed through the `.token(number:)` function.

```swift
var body: some View {
  VStack(spacing: .token(dimension: .small)) {
    ...
  }
}
``` 

### Gradients

Gradient tokens translate into the `GradientToken` custom type. Similarly to previous types, gradients can be accessed via the `.token(_:)` static function.

```swift
var body: some View {
  .backgroundStyle(
    .linearGradient(
      .token(.background),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  )
}
```

#  Output

The command line tool generates source code as the resulting output of the design tokens translation. Some tokens also support several formats for source code customization.

## Name spacing

To prevent naming conflicts between tokens, `design-tokens` preserves the name space (or token path) of the token, and uses a prettified version of the token path as its name.

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

## Token Formats

### Aliases

Alias tokens will always use the format of their referenced token's type, and will be formatted as a computed property.

### Colors

Color tokens support different source code formats for SwiftUI, and UIKit.

#### SwiftUI

The SwiftUI format extends the `Color` type with static properties generated from the color token values, and aliases.

```swift
  extension Color {
    static let black = Color(red: 0, green: 0, blue: 0, opacity: 0)
    
    static var textPrimary: Color { black }
  }
}
```

#### UIKit

Similarly to the SwiftUI format, the UIKit format extends the `UIColor` type.

```swift
  extension UIColor {
    static let black = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    static var textPrimary: UIColor { black }
  }
}
```

### Dimension

Dimension tokens do not support format customization, as the generated source code is always an extension on Foundation's `CGFloat` type.

```swift
extension CGFloat {
  static let small: CGFloat = 16
}
```

### Gradient

Gradient tokens do not currently support format customization, and will default to SwiftUI source code generation, by extending the `Gradient` type.

```swift
extension Gradient {
  static let blueToRed = Gradient(
    stops: [
      Gradient.Stop(
        color: Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 1.0),
        location: 0.0
      ),
      Gradient.Stop(
        color: Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0),
        location: 1.0
      ),
    ]
  )
}
```

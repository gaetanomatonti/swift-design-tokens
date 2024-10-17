#  Output

The command line tool generates source code output for the specified design tokens files. The format for some tokens can also be customized.

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

## Tokens

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
    static let black = Color(red: 0, green: 0, blue: 0, alpha: 0)
    
    static var textPrimary: UIColor { black }
  }
}
```

### Dimension

Dimension tokens do not support format customization, as the generated source code is an extension on Foundation's `CGFloat` type.

```json
{
  "small": {
    "$type": "dimension",
    "$value": "16 px"
  }
}
```

The resulting source code output is as follows:

```swift
extension CGFloat {
  static let small: CGFloat = 16
}
```
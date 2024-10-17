<picture>
  <source srcset="images/header/dark.png" media="(prefers-color-scheme: dark)"/>
  <source srcset="images/header/light.png"  media="(prefers-color-scheme: light)"/>
  <img src="images/header/dark.png"/>
</picture>

## What's `design-tokens`?

`design-tokens` is a command line tool to translate design tokens into Swift source code.
This package follows the [W3C Design Token standard](https://tr.designtokens.org/format/#:~:text=The%20names%20of%20the%20groups,which%20is%20a%20computed%20property) for the translation.

## Install

### Compile sources

To compile the binary, run the following command in the directory of the cloned repository:
```bash
swift build -c release design-tokens
```

## Configuration

The tool must be configured via a [configuration manifest](Documentation/Configuration.md) JSON file to run. 

## Usage

The command line tool provides two commands.

### `init`
Scaffolds a configuration manifest file with default parameters. To scaffold a configuration, the path to the input design token file is required.

```bash
design-tokens init -i design-tokens.json
```

### `generate`
Generates the output as configured in the configuration manifest.

```bash
design-tokens generate
```

#### Example

```json
{
  "input": "design-tokens.json",
  "colors": {
    "formats": [
      "SwiftUI",
      "UIKit"
    ],
    "output": "Output/Colors/"
  },
  "dimensions": {
    "output": "Output/Dimensions/"
  }
}
```

Using the manifest above, the `generate` command will generate `SwiftUI`, and `UIKit` source code for the color tokens in the `Output/Colors/` directory. It will also generate source code (default) for the `dimension` tokens in the `Output/Dimensions/` directory.

Some tokens also support different formats for the generated source code [output](Documentation/Output.md).

## What's `design-tokens`?

`design-tokens` is a command line tool to translate design tokens into Swift source code.
This package follows the [W3C Design Token standard](https://tr.designtokens.org/format/#:~:text=The%20names%20of%20the%20groups,which%20is%20a%20computed%20property) for the translation.

## Install

### Compile sources

To compile the binary, run the following command in the directory of the cloned repository:
```bash
swift build -c release design-tokens
```

## Configuration manifest

The tool must be configured via a configuration manifest JSON file to run. The manifest has the following parameters:

- `input`: The path to the input design tokens JSON.
- `outputs`: An array of outputs that should be generated.
  - `colors`: The tool will generate outputs for any color tokens in the design tokens JSON.
    - `path`: The path of the directory where the output should be generated.
    - `formats`: The list of formats for the generated outputs. (Possible values: SwiftUI, UIKit).
  - `dimensions`: The tool will generate outputs for any dimension tokens in the design tokens JSON.
    - `path`: The path of the directory where the output should be generated.

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
  "input" : "design-tokens.json",
  "output" : {
    "colors" : {
      "formats" : [
        "SwiftUI",
        "UIKit",
      ],
      "path" : "Output/Colors/"
    },
    "dimensions" : {
      "path" : "Output/Dimensions/"
    }
  }
}
```

Using the manifest above, the `generate` command will generate `SwiftUI`, and `UIKit` source code for the color tokens in the `Output/Colors/` directory. It will also generate source code (default) for the `dimension` tokens in the `Output/Dimensions/` directory.

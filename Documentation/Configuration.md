#  Configuration

The command line tool requires a configuration manifest file to generate source code. The configuration manifest has the following parameters:

- `input`: The path to the input design token files. (optional)
- `output`: The path to the directory where the output should be generated. (optional)
- `colors`: The tool will generate outputs for any color tokens in the design tokens JSON.
  - `input`: The path to the input design token files. (default: global `input`)
  - `output`: The path of the directory where the output should be generated. (default: global `output`)
  - `formats`: The list of formats for the generated outputs. (Possible values: SwiftUI, UIKit).
- `dimensions`: The tool will generate outputs for any dimension tokens in the design tokens JSON.
  - `input`: The path to the input design token files. (default: global `input`)
  - `output`: The path of the directory where the output should be generated. (default: global `output`)
- `numbers`: The tool will generate outputs for any number tokens in the design tokens JSON.
  - `input`: The path to the input design token files. (default: global `input`)
  - `output`: The path of the directory where the output should be generated. (default: global `output`)
- `gradients`: The tool will generate outputs for any gradient tokens in the design tokens JSON. Requires `numbers` to be set.
  - `input`: The path to the input design token files. (default: global `input`)
  - `output`: The path of the directory where the output should be generated. (default: global `output`)

## Examples

### Global Input and Output
The following manifest configures the command line tool to generate tokens from a single design tokens file, all in the same directory.
```json
{
  "input": "design-tokens.json",
  "output": "Output/",
  "colors": {
    "formats": [
      "SwiftUI"
    ]
  }
}
```

### Specific Input and Output
The following manifest configures the command line tool to generate tokens from multiple design tokens files, in different directories.
```json
{
  "colors": {
    "input": "design-tokens-colors.json",
    "output": "Output/Colors/",
    "formats": [
      "SwiftUI"
    ]
  }
}
```

### Mixed definition
Specific token configurations can inherit the global input, or output, if no specific one is provided.
```json
{
  "input": "design-tokens.json",
  "output": "Output/",
  "colors": {
    "input": "design-tokens-colors.json",
    "output": "Output/Colors/",
    "formats": [
      "SwiftUI"
    ]
  },
  "dimensions": {}
}
```
In this case, the dimension tokens will use the `design-tokens.json` input file, and source code will be generated in the `Output/` directory.

### Multiple Inputs
Multiple inputs can be provided globally, or for each token-specific configuration.
```json
{
  "output": "Output/",
  "colors": {
    "input": [
      "design-tokens-color-foundations.json", 
      "design-tokens-color-brand.json"
    ],
    "output": "Output/Colors/",
    "formats": [
      "SwiftUI"
    ]
  }
}
```

### Failures
If no input, or output is specified in the manifest, the generation process will fail.

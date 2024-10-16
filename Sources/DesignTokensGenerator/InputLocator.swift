import Foundation

/// An object that locates the configuration file.
struct InputLocator {
  
  // MARK: - Stored Properties
  
  /// The paths to the input files.
  let inputPaths: [String]
  
  // MARK: - Init
  
  init(inputPaths: [String]) {
    self.inputPaths = inputPaths
  }
  
  // MARK: - Functions
  
  /// Locates the input files using the passed configuration manifest locator.
  /// - Parameter configurationLocator: The configuration locator that locates the configuration manifest.
  /// - Returns: An array of `URL` for the input files.
  func locate(using configurationLocator: ConfigurationLocator) -> [URL] {
    inputPaths.reduce(into: []) { result, inputPath in
      let inputURL = configurationLocator.directoryURL.appending(path: inputPath)
      result.append(inputURL)
    }
  }
}

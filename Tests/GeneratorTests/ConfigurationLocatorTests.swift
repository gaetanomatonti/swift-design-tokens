import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationLocatorTests {
  @Test
  func initializationWithFileURLIsSuccessful() throws {
    let directoryURL = FileManager.default.temporaryDirectory
    let locationURL = directoryURL
      .appending(path: "configuration")
      .appendingPathExtension("json")

    #expect(throws: Never.self) {
      try ConfigurationLocator(configurationManifestURL: locationURL)
    }
  }
  
  @Test
  func initializationWithDirectoryURLFails() throws {
    let directoryURL = FileManager.default.temporaryDirectory

    #expect(throws: ConfigurationLocator.Failure.invalidManifestURL) {
      try ConfigurationLocator(configurationManifestURL: directoryURL)
    }
  }

  @Test
  func directoryURLIsComputedCorrectly() throws {
    let directoryURL = FileManager.default.temporaryDirectory
    let locationURL = directoryURL
      .appending(path: "configuration")
      .appendingPathExtension("json")

    let locator = try ConfigurationLocator(configurationManifestURL: locationURL)
    
    #expect(locator.directoryURL == directoryURL)
  }
}

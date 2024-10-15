import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationLocatorTests {
  @Test
  func configurationManifestLocationFromFile() throws {
    let directoryURL = FileManager.default.temporaryDirectory
    let locationURL = directoryURL
      .appending(path: "configuration")
      .appendingPathExtension("json")
    
    let locator = ConfigurationLocator(fileName: "configuration", configurationURL: locationURL)
    
    #expect(locator.fileURL == locationURL)
    #expect(locator.directoryURL == directoryURL)
  }
  
  @Test
  func configurationManifestLocationFromDirectory() throws {
    let directoryURL = FileManager.default.temporaryDirectory
    let locationURL = directoryURL
      .appending(path: "configuration")
      .appendingPathExtension("json")
    
    let locator = ConfigurationLocator(fileName: "configuration", configurationURL: directoryURL)
    
    #expect(locator.fileURL == locationURL)
    #expect(locator.directoryURL == directoryURL)
  }
}

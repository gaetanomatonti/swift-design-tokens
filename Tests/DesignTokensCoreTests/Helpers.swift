import Foundation

func loadJSON(named fileName: String) -> Data? {
  guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
    return nil
  }

  return try? Data(contentsOf: url)
}

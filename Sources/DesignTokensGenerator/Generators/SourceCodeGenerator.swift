import Foundation
import Stencil
import StencilSwiftKit

protocol SourceCodeGenerator {
  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile]
}

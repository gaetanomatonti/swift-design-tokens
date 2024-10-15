import Foundation
import Stencil
import StencilSwiftKit

/// A protocol defining requirements for a source code generator.
protocol SourceCodeGenerator {
  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile]
}

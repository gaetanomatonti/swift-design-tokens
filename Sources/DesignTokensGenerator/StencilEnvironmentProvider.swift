import Foundation
import Stencil
import StencilSwiftKit

enum StencilEnvironmentProvider {
  static func main() -> Environment {
    let loader = Stencil.FileSystemLoader(bundle: [Bundle.module])
    let stencilSwiftExtension = Extension()
    stencilSwiftExtension.registerStencilSwiftExtensions()

    return Stencil.Environment(
      loader: loader,
      extensions: [stencilSwiftExtension],
      trimBehaviour: .smart
    )
  }
}

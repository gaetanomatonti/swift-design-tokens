import Foundation
import Stencil
import StencilSwiftKit

/// A provider of `Stencil.Environment`.
enum StencilEnvironmentProvider {
  /// Creates the environment used to generate Swift source code.
  static func swift() -> Environment {
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

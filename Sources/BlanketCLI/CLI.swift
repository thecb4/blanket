//
//  File.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-29 (09).
//

import ArgumentParser
import BlanketKit
import Foundation

public struct CLI: ParsableCommand {

  public init() {}

  public static var configuration = CommandConfiguration(
    commandName: "blanket",
    abstract: "Reports code coverage",
    discussion:
      """
      Looks for the code coverage associated with the package
      """
  )

  @Option(help: "source path for coverage")
  var sourcePath: String?

  @Option(help: "Coverage File Path")
  var coverageFile: String?

  public func run() throws {

    Blanket.sourcePath = internalSourcePath

    let blanket = try Blanket(contentsOfFile: internalCoverageFile)

    let transformer = Transformer.textTable

    let table = transformer.fancyString(for: blanket.summary) ?? "no data"

    print(table)

  }

  var internalSourcePath: String {
    sourcePath ?? defaultSourcePath
  }

  var internalCoverageFile: String {
    coverageFile ?? defaultCoverageFile
  }

  var defaultCoverageFile: String {
    guard let package = FileManager.default.currentDirectoryURL?.lastPathComponent else {
      return ""
    }

    guard
      let url = FileManager.default.currentDirectoryURL?.appendingPathComponent(
        ".build/debug/codecov/\(package).json"
      )
    else {
      return ""
    }

    return url.path
  }

  var defaultSourcePath: String {
    "Sources"
  }

}

extension FileManager {
  var currentDirectoryURL: URL? {
    URL(fileURLWithPath: currentDirectoryPath)
  }
}

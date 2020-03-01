//
//  File.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-29 (09).
//

public struct SummaryItem {
  let file: String
  let regions: Int
  let coveredRegions: Int
  let regionCoverageRate: Int
  let functions: Int
  let coveredFunctions: Int
  let functionCoverageRate: Int
  let lines: Int
  let coveredLines: Int
  let coveredLinesRate: Int
}

extension Blanket {

  public static var sourcePath = "Sources"

  var files: [File] {
    data.map { $0.files }.flatMap { $0 }.filter { !$0.filename.contains(".build") }.filter {
      $0.filename.contains(Blanket.sourcePath)
    }
  }

  public var summary: [SummaryItem] {
    files.map { $0.summaryItem }
  }
}

extension File {
  var summaryItem: SummaryItem {
    SummaryItem(
      file: filename.path(startingAt: Blanket.sourcePath),
      regions: summary.regions.count,
      coveredRegions: summary.regions.covered,
      regionCoverageRate: 100 * summary.regions.covered / summary.regions.count,
      functions: summary.functions.count,
      coveredFunctions: summary.functions.covered,
      functionCoverageRate: 100 * summary.functions.covered / summary.functions.count,
      lines: summary.lines.count,
      coveredLines: summary.lines.covered,
      coveredLinesRate: 100 * summary.lines.covered / summary.lines.count
    )
  }
}

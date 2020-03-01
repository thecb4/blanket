//
//  File.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-29 (09).
//

import TextTable

public struct Transformer {}

extension Transformer {
  public static var textTable: TextTable<SummaryItem> {
    TextTable<SummaryItem> {
      [
        Column("File" <- $0.file),
        Column("Regions" <- $0.regions, align: .right),
        Column("Region Coverage" <- $0.coveredRegions, align: .right),
        Column("Coverage %" <- $0.regionCoverageRate, align: .right),
        Column("Functions" <- $0.functions, align: .right),
        Column("Function Coverage" <- $0.coveredFunctions, align: .right),
        Column("Coverage %" <- $0.functionCoverageRate, align: .right),
        Column("Lines" <- $0.lines, align: .right),
        Column("Line Coverage" <- $0.coveredLines, align: .right),
        Column("Coverage %" <- $0.coveredLinesRate, align: .right),
      ]
    }
  }
}

extension TextTable where T == SummaryItem {
  public func fancyString<C: Collection>(for data: C) -> String? where C.Iterator.Element == T {
    string(for: data, style: Style.fancy)
  }
}

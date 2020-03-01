// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let blanket = try? newJSONDecoder().decode(Blanket.self, from: jsonData)


import Foundation

// MARK: - CodeCoverage
public struct Blanket: Codable, Hashable {

  public let data: [Datum]
  public let type: String
  public let version: String
}

extension Blanket {

  public init(contentsOfFile path: String) throws {

    let source = try String(contentsOfFile: path)

    let data = Data(source.utf8)

    self = try JSONDecoder().decode(Blanket.self, from: data)

  }

}

// MARK: - Datum
public struct Datum: Codable, Hashable {
  public let files: [File]
  public let functions: [Function]
  public let totals: Totals

}

// MARK: - File
public struct File: Codable, Hashable {
  public let expansions: [String]
  public let filename: String
  public let segments: [[Segment]]
  public let summary: Totals
}

public enum Segment: Codable, Hashable {
  case bool(Bool)
  case integer(Int)

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode(Bool.self) {
      self = .bool(x)
      return
    }
    if let x = try? container.decode(Int.self) {
      self = .integer(x)
      return
    }
    throw DecodingError.typeMismatch(
      Segment.self,
      DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Wrong type for Segment"
      )
    )
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .bool(let x):
      try container.encode(x)
    case .integer(let x):
      try container.encode(x)
    }
  }
}

// MARK: - Totals
public struct Totals: Codable, Hashable {
  public let functions: Functions
  public let instantiations: Functions
  public let lines: Functions
  public let regions: Functions
}


// MARK: - Functions
public struct Functions: Codable, Hashable {
  public let count: Int
  public let covered: Int
  public let percent: Double
  public let notcovered: Int?
}

// MARK: - Function
public struct Function: Codable, Hashable {
  public let count: Int
  public let filenames: [String]
  public let name: String
  public let regions: [[Int]]
}

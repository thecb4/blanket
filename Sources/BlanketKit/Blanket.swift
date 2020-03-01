// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let codeCoverage = try? newJSONDecoder().decode(CodeCoverage.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - CodeCoverage
public struct Blanket: Codable, Hashable {

  public let data: [Datum]
  public let type: String
  public let version: String

  enum CodingKeys: String, CodingKey {
    case data
    case type
    case version
  }

  public init(data: [Datum], type: String, version: String) {
    self.data = data
    self.type = type
    self.version = version
  }
}

extension Blanket {

  public init(contentsOfFile path: String) throws {

    let source = try String(contentsOfFile: path)

    let data = Data(source.utf8)

    self = try JSONDecoder().decode(Blanket.self, from: data)

  }

}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Datum
public struct Datum: Codable, Hashable {
  public let files: [File]
  public let functions: [Function]
  public let totals: Totals

  enum CodingKeys: String, CodingKey {
    case files
    case functions
    case totals
  }

  public init(files: [File], functions: [Function], totals: Totals) {
    self.files = files
    self.functions = functions
    self.totals = totals
  }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - File
public struct File: Codable, Hashable {
  public let expansions: [String]
  public let filename: String
  public let segments: [[Segment]]
  public let summary: Totals

  enum CodingKeys: String, CodingKey {
    case expansions
    case filename
    case segments
    case summary
  }

  public init(expansions: [String], filename: String, segments: [[Segment]], summary: Totals) {
    self.expansions = expansions
    self.filename = filename
    self.segments = segments
    self.summary = summary
  }
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

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Totals
public struct Totals: Codable, Hashable {
  public let functions: Functions
  public let instantiations: Functions
  public let lines: Functions
  public let regions: Functions

  enum CodingKeys: String, CodingKey {
    case functions
    case instantiations
    case lines
    case regions
  }

  public init(functions: Functions, instantiations: Functions, lines: Functions, regions: Functions)
  {
    self.functions = functions
    self.instantiations = instantiations
    self.lines = lines
    self.regions = regions
  }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Functions
public struct Functions: Codable, Hashable {
  public let count: Int
  public let covered: Int
  public let percent: Double
  public let notcovered: Int?

  enum CodingKeys: String, CodingKey {
    case count
    case covered
    case percent
    case notcovered
  }

  public init(count: Int, covered: Int, percent: Double, notcovered: Int?) {
    self.count = count
    self.covered = covered
    self.percent = percent
    self.notcovered = notcovered
  }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Function
public struct Function: Codable, Hashable {
  public let count: Int
  public let filenames: [String]
  public let name: String
  public let regions: [[Int]]

  enum CodingKeys: String, CodingKey {
    case count
    case filenames
    case name
    case regions
  }

  public init(count: Int, filenames: [String], name: String, regions: [[Int]]) {
    self.count = count
    self.filenames = filenames
    self.name = name
    self.regions = regions
  }
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }

  public var hashValue: Int {
    return 0
  }

  public func hash(into hasher: inout Hasher) {
    // No-op
  }

  public init() {}

  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(
        JSONNull.self,
        DecodingError.Context(
          codingPath: decoder.codingPath,
          debugDescription: "Wrong type for JSONNull"
        )
      )
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}

class JSONCodingKey: CodingKey {
  let key: String

  required init?(intValue: Int) {
    return nil
  }

  required init?(stringValue: String) {
    key = stringValue
  }

  var intValue: Int? {
    return nil
  }

  var stringValue: String {
    return key
  }
}

public class JSONAny: Codable {

  public let value: Any

  static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
    let context = DecodingError.Context(
      codingPath: codingPath,
      debugDescription: "Cannot decode JSONAny"
    )
    return DecodingError.typeMismatch(JSONAny.self, context)
  }

  static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
    let context = EncodingError.Context(
      codingPath: codingPath,
      debugDescription: "Cannot encode JSONAny"
    )
    return EncodingError.invalidValue(value, context)
  }

  static func decode(from container: SingleValueDecodingContainer) throws -> Any {
    if let value = try? container.decode(Bool.self) {
      return value
    }
    if let value = try? container.decode(Int64.self) {
      return value
    }
    if let value = try? container.decode(Double.self) {
      return value
    }
    if let value = try? container.decode(String.self) {
      return value
    }
    if container.decodeNil() {
      return JSONNull()
    }
    throw decodingError(forCodingPath: container.codingPath)
  }

  static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
    if let value = try? container.decode(Bool.self) {
      return value
    }
    if let value = try? container.decode(Int64.self) {
      return value
    }
    if let value = try? container.decode(Double.self) {
      return value
    }
    if let value = try? container.decode(String.self) {
      return value
    }
    if let value = try? container.decodeNil() {
      if value {
        return JSONNull()
      }
    }
    if var container = try? container.nestedUnkeyedContainer() {
      return try decodeArray(from: &container)
    }
    if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
      return try decodeDictionary(from: &container)
    }
    throw decodingError(forCodingPath: container.codingPath)
  }

  static func decode(
    from container: inout KeyedDecodingContainer<JSONCodingKey>,
    forKey key: JSONCodingKey
  ) throws -> Any {
    if let value = try? container.decode(Bool.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(Int64.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(Double.self, forKey: key) {
      return value
    }
    if let value = try? container.decode(String.self, forKey: key) {
      return value
    }
    if let value = try? container.decodeNil(forKey: key) {
      if value {
        return JSONNull()
      }
    }
    if var container = try? container.nestedUnkeyedContainer(forKey: key) {
      return try decodeArray(from: &container)
    }
    if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
      return try decodeDictionary(from: &container)
    }
    throw decodingError(forCodingPath: container.codingPath)
  }

  static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
    var arr: [Any] = []
    while !container.isAtEnd {
      let value = try decode(from: &container)
      arr.append(value)
    }
    return arr
  }

  static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws
    -> [String: Any]
  {
    var dict = [String: Any]()
    for key in container.allKeys {
      let value = try decode(from: &container, forKey: key)
      dict[key.stringValue] = value
    }
    return dict
  }

  static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
    for value in array {
      if let value = value as? Bool {
        try container.encode(value)
      } else if let value = value as? Int64 {
        try container.encode(value)
      } else if let value = value as? Double {
        try container.encode(value)
      } else if let value = value as? String {
        try container.encode(value)
      } else if value is JSONNull {
        try container.encodeNil()
      } else if let value = value as? [Any] {
        var container = container.nestedUnkeyedContainer()
        try encode(to: &container, array: value)
      } else if let value = value as? [String: Any] {
        var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
        try encode(to: &container, dictionary: value)
      } else {
        throw encodingError(forValue: value, codingPath: container.codingPath)
      }
    }
  }

  static func encode(
    to container: inout KeyedEncodingContainer<JSONCodingKey>,
    dictionary: [String: Any]
  ) throws {
    for (key, value) in dictionary {
      let key = JSONCodingKey(stringValue: key)!
      if let value = value as? Bool {
        try container.encode(value, forKey: key)
      } else if let value = value as? Int64 {
        try container.encode(value, forKey: key)
      } else if let value = value as? Double {
        try container.encode(value, forKey: key)
      } else if let value = value as? String {
        try container.encode(value, forKey: key)
      } else if value is JSONNull {
        try container.encodeNil(forKey: key)
      } else if let value = value as? [Any] {
        var container = container.nestedUnkeyedContainer(forKey: key)
        try encode(to: &container, array: value)
      } else if let value = value as? [String: Any] {
        var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
        try encode(to: &container, dictionary: value)
      } else {
        throw encodingError(forValue: value, codingPath: container.codingPath)
      }
    }
  }

  static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
    if let value = value as? Bool {
      try container.encode(value)
    } else if let value = value as? Int64 {
      try container.encode(value)
    } else if let value = value as? Double {
      try container.encode(value)
    } else if let value = value as? String {
      try container.encode(value)
    } else if value is JSONNull {
      try container.encodeNil()
    } else {
      throw encodingError(forValue: value, codingPath: container.codingPath)
    }
  }

  public required init(from decoder: Decoder) throws {
    if var arrayContainer = try? decoder.unkeyedContainer() {
      self.value = try JSONAny.decodeArray(from: &arrayContainer)
    } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
      self.value = try JSONAny.decodeDictionary(from: &container)
    } else {
      let container = try decoder.singleValueContainer()
      self.value = try JSONAny.decode(from: container)
    }
  }

  public func encode(to encoder: Encoder) throws {
    if let arr = self.value as? [Any] {
      var container = encoder.unkeyedContainer()
      try JSONAny.encode(to: &container, array: arr)
    } else if let dict = self.value as? [String: Any] {
      var container = encoder.container(keyedBy: JSONCodingKey.self)
      try JSONAny.encode(to: &container, dictionary: dict)
    } else {
      var container = encoder.singleValueContainer()
      try JSONAny.encode(to: &container, value: self.value)
    }
  }
}

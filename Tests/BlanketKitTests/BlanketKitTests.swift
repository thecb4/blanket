import XCTest
@testable import BlanketKit

final class BlanketKitTests: XCTestCase {
  
  func testMakePathRelativeIncludeStart() {
    // given
    let string   = "/Development/toolbox/Blanket/Sources/Blanket/Blanket.swift"
    let expected = "Sources/Blanket/Blanket.swift"
    
    // when
    let actual = string.path(startingAt: "Sources")
    
    XCTAssertEqual(actual, expected)
    
  }
  
  func testMakePathRelativeExcludeStart() {
    // given
    let string   = "/Development/toolbox/Blanket/Sources/Blanket/Blanket.swift"
    let expected = "Blanket/Blanket.swift"
    
    // when
    let actual = string.path(startingAt: "Sources", excludeStart: true)
    
    // then
    XCTAssertEqual(actual, expected)
    
  }
  
  func testFunctions() {
    // given
    
    // when
    let functions = Functions(count: 100, covered: 2, percent: Double(2/100), notcovered: nil)
    
    // then
    XCTAssertEqual(functions.count,100)
    XCTAssertEqual(functions.covered,2)
    XCTAssertEqual(functions.percent,Double(2/100))
    XCTAssertNil(functions.notcovered)
  }
  
  func testBlanket() throws {
    
    // given
    
    let source  = try String(contentsOfFile: sourcePath + "/Tests/fixtures/Blanket.json")
    
    let expected =
      """
      ╒════════════════════════════════════════════╤═════════╤═════════════════╤════════════╤═══════════╤═══════════════════╤════════════╤═══════╤═══════════════╤════════════╕
      │ File                                       │ Regions │ Region Coverage │ Coverage % │ Functions │ Function Coverage │ Coverage % │ Lines │ Line Coverage │ Coverage % │
      ╞════════════════════════════════════════════╪═════════╪═════════════════╪════════════╪═══════════╪═══════════════════╪════════════╪═══════╪═══════════════╪════════════╡
      │ Sources/BlanketCLI/CLI.swift               │      14 │              11 │         78 │        10 │                 9 │         90 │    40 │            37 │         92 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/Blanket.swift           │     147 │               6 │          4 │        29 │                 3 │         10 │   274 │            26 │          9 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/CoverageSummary.swift   │       8 │               8 │        100 │         8 │                 8 │        100 │    25 │            25 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/String+Extensions.swift │       5 │               4 │         80 │         1 │                 1 │        100 │    10 │            10 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/Transformer.swift       │      13 │              13 │        100 │        13 │                13 │        100 │    43 │            43 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Total                                      │     187 │              42 │         22 │        61 │                34 │         55 │   392 │           141 │         35 │
      ╘════════════════════════════════════════════╧═════════╧═════════════════╧════════════╧═══════════╧═══════════════════╧════════════╧═══════╧═══════════════╧════════════╛
      
      """
    
    // when
    let data    = Data(source.utf8)
  
    let blanket = try JSONDecoder().decode(Blanket.self, from:  data)
    
    let transformer = Transformer.textTable
    
    let table = transformer.fancyString(for: blanket.summary) ?? "no data"
    
    
    // then
    XCTAssertEqual(table, expected)
  }
  
  func testBlanketFromFile() throws {
    
    // given
    let source  = sourcePath + "/Tests/fixtures/Blanket.json"
    
    let expected =
      """
      ╒════════════════════════════════════════════╤═════════╤═════════════════╤════════════╤═══════════╤═══════════════════╤════════════╤═══════╤═══════════════╤════════════╕
      │ File                                       │ Regions │ Region Coverage │ Coverage % │ Functions │ Function Coverage │ Coverage % │ Lines │ Line Coverage │ Coverage % │
      ╞════════════════════════════════════════════╪═════════╪═════════════════╪════════════╪═══════════╪═══════════════════╪════════════╪═══════╪═══════════════╪════════════╡
      │ Sources/BlanketCLI/CLI.swift               │      14 │              11 │         78 │        10 │                 9 │         90 │    40 │            37 │         92 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/Blanket.swift           │     147 │               6 │          4 │        29 │                 3 │         10 │   274 │            26 │          9 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/CoverageSummary.swift   │       8 │               8 │        100 │         8 │                 8 │        100 │    25 │            25 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/String+Extensions.swift │       5 │               4 │         80 │         1 │                 1 │        100 │    10 │            10 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/Transformer.swift       │      13 │              13 │        100 │        13 │                13 │        100 │    43 │            43 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Total                                      │     187 │              42 │         22 │        61 │                34 │         55 │   392 │           141 │         35 │
      ╘════════════════════════════════════════════╧═════════╧═════════════════╧════════════╧═══════════╧═══════════════════╧════════════╧═══════╧═══════════════╧════════════╛
      
      """
    
    // when
    let blanket = try Blanket(contentsOfFile: source)
    
    let transformer = Transformer.textTable
    
    let table = transformer.fancyString(for: blanket.summary) ?? "no data"

    // then
    XCTAssertEqual(table, expected)
    
  }

  let sourcePath = {
    String(
      URL(fileURLWithPath: #file)
        .deletingLastPathComponent() // remove file
        .deletingLastPathComponent() // remove Source
        .deletingLastPathComponent() //
        .withoutScheme()
    )
  }()

}

public extension URL {
  func withoutScheme() -> String {
    let urlWithoutScheme = String(
      pathComponents
        .joined(separator: "/")
        .dropFirst()
    )

    return urlWithoutScheme
  }
}

extension UInt8 {
    var character: Character {
        return Character(UnicodeScalar(self))
    }
}

extension String {
  static var executableEnding: String {
    let ending: [UInt8] = [10,10]
    return String(ending.map { $0.character })
  }
}

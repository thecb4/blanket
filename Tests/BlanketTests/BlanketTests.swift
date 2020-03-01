//
//  File.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-29 (09).
//

import XCTest
import class Foundation.Bundle

@available(macOS 10.13, *)
final class BlanketTests: XCTestCase {
  
  // leverage apple's model for running external process
  // https://github.com/apple/swift-stress-tester/blob/master/SourceKitStressTester/Sources/SwiftCWrapper/ProcessRunner.swift
  
  private static let serialQueue = DispatchQueue(label: "\(BlanketTests.self)")
  
  var process: Process!
  var launched = false
  
  func configureProcess(arguments: [String], environment: [String: String] = [:]) {
    process = Process()
    let fooBinary = productsDirectory.appendingPathComponent("blanket")
    process.executableURL = fooBinary
    process.currentDirectoryURL = fixturesURL.appendingPathComponent("SpecialProject")
    process.arguments = arguments
    process.environment = environment.merging(ProcessInfo.processInfo.environment) { (current, _) in current }
  }
  
  func run(capturingOutput: Bool = true) -> (Data, Data) {
    let out = Pipe()
    var outData = Data()
    
    let err = Pipe()
    var errData = Data()

    if capturingOutput {
      process.standardOutput = out
      process.standardError  = err
    }
    BlanketTests.serialQueue.sync {
      process.launch()
      launched = true
    }
    if capturingOutput {
      outData = out.fileHandleForReading.readDataToEndOfFile()
      errData = err.fileHandleForReading.readDataToEndOfFile()
    }
    process.waitUntilExit()

    return (outData, errData)
  }

  func terminate() {
    BlanketTests.serialQueue.sync {
      if launched {
        process.terminate()
        process = nil
      }
    }
  }
  
  func testBlanketRunNoArgs() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.
    
    configureProcess(arguments: [])
    
    let (outData, errData) = run()

    guard let outString = String(data: outData, encoding: .utf8) else { return }
    guard let errString = String(data: errData, encoding: .utf8) else { return }
    
    let expected =
      """
      ╒════════════════════════════════════════════╤═════════╤═════════════════╤════════════╤═══════════╤═══════════════════╤════════════╤═══════╤═══════════════╤════════════╕
      │ File                                       │ Regions │ Region Coverage │ Coverage % │ Functions │ Function Coverage │ Coverage % │ Lines │ Line Coverage │ Coverage % │
      ╞════════════════════════════════════════════╪═════════╪═════════════════╪════════════╪═══════════╪═══════════════════╪════════════╪═══════╪═══════════════╪════════════╡
      │ Sources/BlanketKit/Blanket.swift           │     146 │               5 │          3 │        28 │                 2 │          7 │   265 │            17 │          6 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/CoverageSummary.swift   │       7 │               7 │        100 │         7 │                 7 │        100 │    24 │            24 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/Output.swift            │      13 │              12 │         92 │        13 │                12 │         92 │    43 │            42 │         97 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/String+Extensions.swift │       5 │               4 │         80 │         1 │                 1 │        100 │    10 │            10 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Total                                      │     171 │              28 │        100 │        49 │                22 │         44 │   342 │            93 │         27 │
      ╘════════════════════════════════════════════╧═════════╧═════════════════╧════════════╧═══════════╧═══════════════════╧════════════╧═══════╧═══════════════╧════════════╛
      
      
      """
    
    XCTAssertEqual(outString, expected)
    XCTAssertEqual(errString, "")
    
  }
  
  func testBlanketSimpleArgs() throws {
    
    configureProcess(arguments: ["--source-path", "Sources", "--coverage-file", ".build/debug/codecov/SpecialProject.json"])
    
    let (outData, errData) = run()

    guard let outString = String(data: outData, encoding: .utf8) else { return }
    guard let errString = String(data: errData, encoding: .utf8) else { return }
    
    let expected =
      """
      ╒════════════════════════════════════════════╤═════════╤═════════════════╤════════════╤═══════════╤═══════════════════╤════════════╤═══════╤═══════════════╤════════════╕
      │ File                                       │ Regions │ Region Coverage │ Coverage % │ Functions │ Function Coverage │ Coverage % │ Lines │ Line Coverage │ Coverage % │
      ╞════════════════════════════════════════════╪═════════╪═════════════════╪════════════╪═══════════╪═══════════════════╪════════════╪═══════╪═══════════════╪════════════╡
      │ Sources/BlanketKit/Blanket.swift           │     146 │               5 │          3 │        28 │                 2 │          7 │   265 │            17 │          6 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/CoverageSummary.swift   │       7 │               7 │        100 │         7 │                 7 │        100 │    24 │            24 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/Output.swift            │      13 │              12 │         92 │        13 │                12 │         92 │    43 │            42 │         97 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Sources/BlanketKit/String+Extensions.swift │       5 │               4 │         80 │         1 │                 1 │        100 │    10 │            10 │        100 │
      ├────────────────────────────────────────────┼─────────┼─────────────────┼────────────┼───────────┼───────────────────┼────────────┼───────┼───────────────┼────────────┤
      │ Total                                      │     171 │              28 │        100 │        49 │                22 │         44 │   342 │            93 │         27 │
      ╘════════════════════════════════════════════╧═════════╧═════════════════╧════════════╧═══════════╧═══════════════════╧════════════╧═══════╧═══════════════╧════════════╛
      
      
      """
    
    XCTAssertEqual(outString, expected)
    XCTAssertEqual(errString, "")
  }

  /// Returns path to the built products directory.
  var productsDirectory: URL {
    #if os(macOS)
      for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
          return bundle.bundleURL.deletingLastPathComponent()
      }
      fatalError("couldn't find the products directory")
    #else
      return Bundle.main.bundleURL
    #endif
  }
  
  var testURL: URL {
    guard let fileURL = Bundle(for: type(of: self)).url(forResource: "Package", withExtension: "swift") else {
      return URL(fileURLWithPath: "file:///")
    }
//    guard let fileURL = Bundle(for: type(of: self)).url(forResource: "Package" withExtension:"swift") else {
//            fatalError("File not found")
//    }
    return fileURL
  }
  
  var fixturesURL: URL {
    URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .appendingPathComponent("fixtures")
  }
}

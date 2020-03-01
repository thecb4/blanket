//
//  File.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-29 (09).
//

import XCTest
import ArgumentParser
@testable import BlanketCLI

final class BlanketCLITests: XCTestCase {
  func testCLIArgs() {
    
    AssertParse(CLI.self, []) { foo in
      XCTAssertNil(foo.sourcePath)
      XCTAssertNil(foo.coverageFile)
    }
  
  }
}


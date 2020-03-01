import XCTest

import BlanketCLITests
import BlanketKitTests
import BlanketTests

var tests = [XCTestCaseEntry]()
tests += BlanketCLITests.__allTests()
tests += BlanketKitTests.__allTests()
tests += BlanketTests.__allTests()

XCTMain(tests)

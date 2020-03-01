#if !canImport(ObjectiveC)
import XCTest

extension BlanketKitTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__BlanketKitTests = [
        ("testBlanket", testBlanket),
        ("testBlanketFromFile", testBlanketFromFile),
        ("testFunctions", testFunctions),
        ("testMakePathRelativeExcludeStart", testMakePathRelativeExcludeStart),
        ("testMakePathRelativeIncludeStart", testMakePathRelativeIncludeStart),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BlanketKitTests.__allTests__BlanketKitTests),
    ]
}
#endif

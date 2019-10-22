import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FCPXMLCodableTests.allTests),
    ]
}
#endif

//
//  FCPXMLDocumentEventsTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class FCPXMLDocumentEventsTests: XCTestCase {

    let rootKey = "fcpxml"

    let xmlString = """
<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n<fcpxml version="1.8"><resources><asset id="r1" src="file://asset-url" format="r2" /><format id="r2" /></resources><event name="Test Event 1" /><event name="Test Event 2" /></fcpxml>
"""

    var testValue: FCPXMLDocument {
        var event1 = Event()
        event1.name = "Test Event 1"
        var event2 = Event()
        event2.name = "Test Event 2"
        let asset = Asset(id: "r1", sourceURL: "file://asset-url", formatID: "r2")
        let format = Format(id: "r2")
        let resources = Resources(assets: [asset], formats: [format])
        return FCPXMLDocument(configuration: .events([event1, event2]), resources: resources)
    }

    func testDecode() {
        let decoded = try! FCPXMLConverter.fcpxmlDocument(from: xmlString)
        XCTAssertEqual(decoded, testValue)
    }

    func testEncode() {
        let encoded = try! FCPXMLConverter.xmlString(from: testValue)
        XCTAssertEqual(encoded, xmlString)
    }

    func testConfiguration() {
        guard case let .events(events) = testValue.configuration else { return XCTFail() }
        XCTAssertEqual(events.count, 2)
    }

    func testResourcesDynamicLookup() {
        XCTAssertEqual(testValue.assets?.count, 1)
        XCTAssertEqual(testValue.formats?.count, 1)
    }

    #if os(macOS)
    func testValidate() {
        let document = try! FCPXMLConverter.xmlDocument(from: testValue)
        XCTAssertNoThrow(try document.validateFCPXML())
    }
    #endif

}

//
//  FCPXMLDocumentLibraryTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class FCPXMLDocumentLibraryTests: XCTestCase {

    let rootKey = "fcpxml"

    let xmlString = """
<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n<fcpxml version="1.8"><resources><asset id="r1" src="file://asset-url" format="r2" /><format id="r2" /></resources><library location="file://location"><event name="Test Event" /><smart-collection name="Test Smart Collection" match="any"><match-clip enabled="1" rule="is" type="compound" /></smart-collection></library></fcpxml>
"""

    var testValue: FCPXMLDocument {
        var library = Library(location: "file://location")
        var event = Event()
        event.name = "Test Event"
        library.events = [event]
        var smartCollection = SmartCollection(name: "Test Smart Collection", match: .any)
        smartCollection.matchClips = [MatchClip(type: .compound)]
        library.smartCollections = [smartCollection]
        let asset = Asset(id: "r1", sourceURL: "file://asset-url", formatID: "r2")
        let format = Format(id: "r2")
        let resources = Resources(assets: [asset], formats: [format])
        return FCPXMLDocument(configuration: .library(library), resources: resources)
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
        guard case let .library(library) = testValue.configuration else { return XCTFail() }
        XCTAssertNotNil(library)
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

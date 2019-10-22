//
//  FCPXMLDocumentEventItemsTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class FCPXMLDocumentEventItemsTests: XCTestCase {

    let rootKey = "fcpxml"

    let xmlString = """
<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n<fcpxml version="1.8"><import-options><option key="copy assets" value="1" /><option key="suppress warnings" value="0" /><option key="library location" value="file://test-url" /></import-options><resources><asset id="r1" src="file://asset-url" format="r2" /><format id="r2" /></resources><asset-clip ref="r1" offset="0/1s" /><project><sequence format="r2"><spine name="Test Spine" /></sequence></project></fcpxml>
"""

    var testValue: FCPXMLDocument {
        var spine = Spine()
        spine.name = "Test Spine"
        let sequence = Sequence(formatID: "r2", spine: spine)
        let project = Project(sequence: sequence)
        let assetClip = AssetClip(referenceID: "r1")
        var eventItems = EventItems()
        eventItems.projects = [project]
        eventItems.assetClips = [assetClip]
        let asset = Asset(id: "r1", sourceURL: "file://asset-url", formatID: "r2")
        let format = Format(id: "r2")
        let resources = Resources(assets: [asset], formats: [format])
        var document = FCPXMLDocument(configuration: .eventItems(eventItems), resources: resources)
        document.setShouldCopyAssetsOnImport(true)
        document.setShouldSuppressWarningsOnImport(false)
        document.setLibraryLocationForImport("file://test-url")
        return document
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
        guard case let .eventItems(eventItems) = testValue.configuration else { return XCTFail() }
        XCTAssertEqual(eventItems.projects.count, 1)
        XCTAssertEqual(eventItems.assetClips.count, 1)
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

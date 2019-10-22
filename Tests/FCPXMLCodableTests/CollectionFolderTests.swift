//
//  CollectionFolderTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class CollectionFolderTests: XCTestCase, FCPXMLTestCase {

    typealias T = CollectionFolder

    let rootKey = "collection-folder"

    let xmlString = """
<collection-folder name="Test Folder"><keyword-collection name="Keywords 1" /><keyword-collection name="Keywords 2" /></collection-folder>
"""

    var testValue: CollectionFolder {
        var folder = CollectionFolder(name: "Test Folder")
        let keywordCollection1 = KeywordCollection(name: "Keywords 1")
        let keywordCollection2 = KeywordCollection(name: "Keywords 2")
        folder.keywordCollections = [keywordCollection1, keywordCollection2]
        return folder
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

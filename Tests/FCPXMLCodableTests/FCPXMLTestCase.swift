//
//  FCPXMLTestCase.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable
import XMLCoder

protocol FCPXMLTestCase {

    associatedtype T: Codable, Equatable

    var rootKey: String { get }
    var xmlString: String { get }
    var testValue: T { get }

    func evaluateDecodeTest()
    func evaluateEncodeTest()
    
}

extension FCPXMLTestCase {

    func evaluateDecodeTest() {
        let decoded = try! FCPXMLConverter.decode(T.self, from: xmlString)
        XCTAssertEqual(testValue, decoded)
    }

    func evaluateEncodeTest() {
        let string = try! FCPXMLConverter.xmlString(from: testValue, rootKey: rootKey)
        XCTAssertEqual(xmlString, string)
    }

}

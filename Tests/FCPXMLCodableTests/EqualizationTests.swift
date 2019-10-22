//
//  EqualizationTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class EqualizationTests: XCTestCase, FCPXMLTestCase {

    typealias T = Equalization

    let rootKey = "adjust-EQ"

    let xmlString = """
<adjust-EQ mode="loudness" />
"""

    var testValue: Equalization {
        return Equalization(mode: .loudness)
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

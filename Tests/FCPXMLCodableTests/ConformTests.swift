//
//  ConformTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class ConformTests: XCTestCase, FCPXMLTestCase {

    typealias T = Conform

    let rootKey = "adjust-conform"

    let xmlString = """
<adjust-conform type="fill" />
"""

    var testValue: Conform {
        return Conform(type: .fill)
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

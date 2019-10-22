//
//  BlendTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class BlendTests: XCTestCase, FCPXMLTestCase {

    typealias T = Blend

    let rootKey = "adjust-blend"

    let xmlString = """
<adjust-blend amount="0.6" mode="25 (Stencil Alpha)"><reserved>reserved</reserved></adjust-blend>
"""

    var testValue: Blend {
        var blend = Blend()
        blend.amount = 0.6
        blend.reserved = "reserved"
        blend.mode = "25 (Stencil Alpha)"
        return blend
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetAmount() {
        var blend = Blend()
        XCTAssertEqual(blend.amount, 1.0)
        blend.amount = 0.6
        XCTAssertEqual(blend.amount, 0.6)
    }

}

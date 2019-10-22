//
//  CornersTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class CornersTests: XCTestCase, FCPXMLTestCase {

    typealias T = Corners

    let rootKey = "adjust-corners"

    let xmlString = """
<adjust-corners enabled="1" botLeft="1.2 3.4" topLeft="0.0 0.0" topRight="2.3 4.3" botRight="0.0 0.0"><param name="Look" key="1" value="11 (Video)" /><param name="Amount" key="2" value="50" /></adjust-corners>
"""

    var testValue: Corners {
        var corners = Corners(bottomLeft: Point(x: 1.2, y: 3.4), topLeft: .zero, topRight: Point(x: 2.3, y: 4.3), bottomRight: .zero)
        let param1 = Parameter(name: "Look", key: "1", value: "11 (Video)")
        let param2 = Parameter(name: "Amount", key: "2", value: "50")
        corners.parameters = [param1, param2]
        return corners
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

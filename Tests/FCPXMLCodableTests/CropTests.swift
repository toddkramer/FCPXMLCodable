//
//  CropTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class CropTests: XCTestCase, FCPXMLTestCase {

    typealias T = Crop

    let rootKey = "adjust-crop"

    let xmlString = """
<adjust-crop mode="crop"><crop-rect left="1.1" top="2.2" right="1.1" bottom="2.2" /></adjust-crop>
"""

    var testValue: Crop {
        var crop = Crop(mode: .crop)
        crop.cropRect = CropRect(left: 1.1, top: 2.2, right: 1.1, bottom: 2.2)
        return crop
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetIsEnabled() {
        var crop = Crop(mode: .crop)
        XCTAssertTrue(crop.isEnabled)
        crop.isEnabled = false
        XCTAssertFalse(crop.isEnabled)
    }

}

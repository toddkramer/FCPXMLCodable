//
//  FadeInTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class FadeInTests: XCTestCase, FCPXMLTestCase {

    typealias T = FadeIn

    let rootKey = "fadeIn"

    let xmlString = """
<fadeIn type="linear" duration="48000/24000s" />
"""

    var testValue: FadeIn {
        return FadeIn(type: .linear, duration: CMTime(seconds: 2, preferredTimescale: 24000))
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

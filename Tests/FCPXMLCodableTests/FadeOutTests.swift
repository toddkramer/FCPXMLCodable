//
//  FadeOutTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class FadeOutTests: XCTestCase, FCPXMLTestCase {

    typealias T = FadeOut

    let rootKey = "fadeOut"

    let xmlString = """
<fadeOut type="easeInOut" duration="48000/24000s" />
"""

    var testValue: FadeOut {
        return FadeOut(type: .easeInOut, duration: CMTime(seconds: 2, preferredTimescale: 24000))
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

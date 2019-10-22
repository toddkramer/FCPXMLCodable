//
//  ConformRateTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class ConformRateTests: XCTestCase, FCPXMLTestCase {

    typealias T = ConformRate

    let rootKey = "conform-rate"

    let xmlString = """
<conform-rate scaleEnabled="1" srcFrameRate="29.97" frameSampling="nearest-neighbor" />
"""

    var testValue: ConformRate {
        return ConformRate(sourceFrameRate: .r29_97, frameSampling: .nearestNeighbor)
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

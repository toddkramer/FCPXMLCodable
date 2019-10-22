//
//  AuditionTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AuditionTests: XCTestCase, FCPXMLTestCase {

    typealias T = Audition

    let rootKey = "audition"

    let xmlString = """
<audition offset="0/1s" modDate="2000-12-31 19:00:00 -0500"><asset-clip ref="r1" offset="0/1s" /><asset-clip ref="r2" offset="0/1s" /></audition>
"""

    var testValue: Audition {
        var audition = Audition()
        audition.dateModified = Date(timeIntervalSinceReferenceDate: 0)
        let assetClip1 = AssetClip(referenceID: "r1")
        let assetClip2 = AssetClip(referenceID: "r2")
        audition.assetClips = [assetClip1, assetClip2]
        return audition
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

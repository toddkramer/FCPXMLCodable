//
//  MediaTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class MediaTests: XCTestCase, FCPXMLTestCase {

    typealias T = Media

    let rootKey = "media"

    let xmlString = """
<media id="r1" name="Test Media" modDate="2000-12-31 19:00:00 -0500"><sequence format="r2"><spine name="Test Spine" /></sequence></media>
"""

    var testValue: Media {
        var media = Media(id: "r1", name: "Test Media", dateModified: Date(timeIntervalSinceReferenceDate: 0))
        var spine = Spine()
        spine.name = "Test Spine"
        let sequence = Sequence(formatID: "r2", spine: spine)
        media.sequence = sequence
        return media
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

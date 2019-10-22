//
//  EventTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class EventTests: XCTestCase, FCPXMLTestCase {

    typealias T = Event

    let rootKey = "event"

    let xmlString = """
<event name="Test Event" uid="abcd"><asset-clip ref="r2" lane="1" offset="144000/24000s" name="Anchored Asset 1" /><asset-clip ref="r2" lane="1" offset="192000/24000s" name="Anchored Asset 2" /></event>
"""

    var testValue: Event {
        var event = Event(name: "Test Event", uid: "abcd")
        var assetClip1 = AssetClip(referenceID: "r2", offset: CMTime(seconds: 6, preferredTimescale: 24000), name: "Anchored Asset 1")
        assetClip1.lane = 1
        var assetClip2 = AssetClip(referenceID: "r2", offset: CMTime(seconds: 8, preferredTimescale: 24000), name: "Anchored Asset 2")
        assetClip2.lane = 1
        event.assetClips = [assetClip1, assetClip2]
        return event
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

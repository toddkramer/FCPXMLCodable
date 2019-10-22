//
//  AudioTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AudioTests: XCTestCase, FCPXMLTestCase {

    typealias T = Audio

    let rootKey = "audio"

    let xmlString = """
<audio ref="r1" offset="0/1s" name="Test Audio" duration="480000/24000s" role="dialogue.dialogue-1" srcCh="1, 2" />
"""

    var testValue: Audio {
        return Audio(referenceID: "r1", name: "Test Audio", duration: CMTime(seconds: 20, preferredTimescale: 24000),
                     role: "dialogue.dialogue-1", sourceChannels: "1, 2")
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetIsEnabled() {
        var audio = Audio(referenceID: "r1", duration: CMTime(seconds: 20, preferredTimescale: 24000))
        XCTAssertTrue(audio.isEnabled)
        audio.isEnabled = false
        XCTAssertFalse(audio.isEnabled)
    }

}

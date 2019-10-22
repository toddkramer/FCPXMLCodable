//
//  AudioFilterTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AudioFilterTests: XCTestCase, FCPXMLTestCase {

    typealias T = AudioFilter

    let rootKey = "filter-audio"

    let xmlString = """
<filter-audio ref="r1" name="Audio Crossfade"><data key="effectData">abcd</data></filter-audio>
"""

    var testValue: AudioFilter {
        var audioFilter = AudioFilter(effectID: "r1", name: "Audio Crossfade")
        audioFilter.data = KeyedData(key: "effectData", value: "abcd")
        return audioFilter
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetIsEnabled() {
        var audioFilter = AudioFilter(effectID: "r1")
        XCTAssertTrue(audioFilter.isEnabled)
        audioFilter.isEnabled = false
        XCTAssertFalse(audioFilter.isEnabled)
    }

}

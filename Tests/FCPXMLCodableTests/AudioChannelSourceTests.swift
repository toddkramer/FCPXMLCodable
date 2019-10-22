//
//  AudioChannelSourceTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AudioChannelSourceTests: XCTestCase, FCPXMLTestCase {

    typealias T = AudioChannelSource

    let rootKey = "audio-channel-source"

    let xmlString = """
<audio-channel-source srcCh="1, 2" role="dialogue.dialogue-1"><adjust-noiseReduction amount="50.0" /></audio-channel-source>
"""

    var testValue: AudioChannelSource {
        var audioChannelSource = AudioChannelSource(sourceChannels: "1, 2", role: "dialogue.dialogue-1")
        audioChannelSource.noiseReduction = NoiseReduction(amount: 50)
        return audioChannelSource
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetIsEnabled() {
        var audioChannelSource = AudioChannelSource(sourceChannels: "1, 2")
        XCTAssertTrue(audioChannelSource.isEnabled)
        audioChannelSource.isEnabled = false
        XCTAssertFalse(audioChannelSource.isEnabled)
    }

    func testSetIsActive() {
        var audioChannelSource = AudioChannelSource(sourceChannels: "1, 2")
        XCTAssertTrue(audioChannelSource.isActive)
        audioChannelSource.isActive = false
        XCTAssertFalse(audioChannelSource.isActive)
    }

}

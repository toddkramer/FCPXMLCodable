//
//  AudioRoleSourceTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AudioRoleSourceTests: XCTestCase, FCPXMLTestCase {

    typealias T = AudioRoleSource

    let rootKey = "audio-role-source"

    let xmlString = """
<audio-role-source role="dialogue.dialogue-1"><adjust-humReduction frequency="60" /></audio-role-source>
"""

    var testValue: AudioRoleSource {
        var audioRoleSource = AudioRoleSource(role: "dialogue.dialogue-1")
        audioRoleSource.humReduction = HumReduction(frequency: .k60)
        return audioRoleSource
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetIsEnabled() {
        var audioRoleSource = AudioRoleSource(role: "dialogue.dialogue-1")
        XCTAssertTrue(audioRoleSource.isEnabled)
        audioRoleSource.isEnabled = false
        XCTAssertFalse(audioRoleSource.isEnabled)
    }

    func testSetIsActive() {
        var audioRoleSource = AudioRoleSource(role: "dialogue.dialogue-1")
        XCTAssertTrue(audioRoleSource.isActive)
        audioRoleSource.isActive = false
        XCTAssertFalse(audioRoleSource.isActive)
    }

}

//
//  KeyframeAnimationTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class KeyframeAnimationTests: XCTestCase, FCPXMLTestCase {

    typealias T = KeyframeAnimation

    let rootKey = "keyframeAnimation"

    let xmlString = """
<keyframeAnimation><keyframe time="0/1s" value="-5 10" curve="linear" interp="easeIn" /><keyframe time="1/1s" value="-2 8" curve="linear" interp="easeOut" /></keyframeAnimation>
"""

    var testValue: KeyframeAnimation {
        let keyframe1 = Keyframe(time: CMTime(seconds: 0, preferredTimescale: 1), value: "-5 10", interpolation: .easeIn, curve: .linear)
        let keyframe2 = Keyframe(time: CMTime(seconds: 1, preferredTimescale: 1), value: "-2 8", interpolation: .easeOut, curve: .linear)
        let animation = KeyframeAnimation(keyframes: [keyframe1, keyframe2])
        return animation
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}


//
//  EffectTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
import FCPXMLCodable

final class EffectTests: XCTestCase, FCPXMLTestCase {

    typealias T = Effect

    let rootKey = "effect"

    let xmlString = """
<effect id="r1" name="Test Effect" uid="abcd" src="fileURL" />
"""

    var testValue: Effect {
        var effect = Effect(id: "r1", name: "Test Effect", uid: "abcd")
        effect.sourceURL = "fileURL"
        return effect
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

//
//  CaptionTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class CaptionTests: XCTestCase, FCPXMLTestCase {

    typealias T = Caption

    let rootKey = "caption"

    let xmlString = """
<caption offset="0/1s" name="This is a test caption name." duration="120000/24000s" role="iTT?captionFormat=ITT.en"><text placement="bottom"><text-style ref="ts1">This is a caption value.</text-style></text><text-style-def id="ts1"><text-style font=".SF NS Text" fontFace="Regular" fontColor="0.0 0.0 1.0 1.0" backgroundColor="0.0 0.0 0.0 1.0" /></text-style-def></caption>
"""

    var testValue: Caption {
        var caption = Caption(name: "This is a test caption name.", duration: CMTime(seconds: 5, preferredTimescale: 24000),
                              role: "iTT?captionFormat=ITT.en")
        var text = Text()
        text.placement = .bottom
        let textStyle = TextStyle(referenceID: "ts1", value: "This is a caption value.")
        text.textStyles = [textStyle]
        var textStyleDefinition = TextStyleDefinition(id: "ts1")
        var definitionTextStyle = TextStyle()
        definitionTextStyle.font = ".SF NS Text"
        definitionTextStyle.fontFace = "Regular"
        definitionTextStyle.fontColor = .blue
        definitionTextStyle.backgroundColor = .black
        textStyleDefinition.textStyles = [definitionTextStyle]
        caption.texts = [text]
        caption.textStyleDefinitions = [textStyleDefinition]
        return caption
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetIsEnabled() {
        var caption = Caption(duration: CMTime(seconds: 5, preferredTimescale: 24000))
        XCTAssertTrue(caption.isEnabled)
        caption.isEnabled = false
        XCTAssertFalse(caption.isEnabled)
    }

}

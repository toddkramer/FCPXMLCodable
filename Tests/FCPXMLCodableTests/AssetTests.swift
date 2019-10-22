//
//  AssetTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AssetTests: XCTestCase, FCPXMLTestCase {

    typealias T = Asset

    let rootKey = "asset"

    let xmlString = """
<asset id="r1" name="Test Asset" uid="uid" start="0/1s" duration="120000/24000s" hasVideo="1" hasAudio="1" audioSources="1" audioChannels="2" audioRate="44100" customLUTOverride="Custom LUT" colorSpaceOverride="9-18-9 (Rec. 2020 HLG)" projectionOverride="equirectangular" stereoscopicOverride="side by side" src="file://testurl" format="r2"><bookmark>bookmark</bookmark><metadata><md key="Test Metadata" value="Custom Value" editable="1" type="string" displayName="Custom Metadata" /></metadata></asset>
"""

    var testValue: Asset {
        let duration = CMTime(seconds: 5, preferredTimescale: 24000)
        var asset = Asset(id: "r1", name: "Test Asset", uid: "uid", sourceURL: "file://testurl", start: .zero, duration: duration, hasVideo: true,
                           hasAudio: true, formatID: "r2", audioSources: 1, audioChannels: 2, audioRate: 44100)
        asset.customLUTOverride = "Custom LUT"
        asset.colorSpaceOverride = .rec2020HLG
        asset.projectionOverride = .equirectangular
        asset.stereoscopicOverride = .sideBySide
        asset.bookmark = "bookmark"
        asset.metadata = [metadatum]
        return asset
    }

    private var metadatum: Metadatum {
        var metadatum = Metadatum(key: "Test Metadata", value: "Custom Value")
        metadatum.isEditable = true
        metadatum.type = .string
        metadatum.displayName = "Custom Metadata"
        return metadatum
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

    func testSetMetadata() {
        var asset = Asset(id: "r1", sourceURL: "url")
        XCTAssertNil(asset.metadata)
        asset.metadata = [metadatum]
        XCTAssertEqual(asset.metadata, [metadatum])
    }

}

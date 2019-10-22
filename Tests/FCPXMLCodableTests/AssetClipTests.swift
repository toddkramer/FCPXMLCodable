//
//  AssetClipTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AssetClipTests: XCTestCase, FCPXMLTestCase {

    typealias T = AssetClip

    let rootKey = "asset-clip"

    let xmlString = """
<asset-clip ref="r1" offset="0/1s" name="Test Asset Clip" start="120000/24000s"><note>Test Note</note><adjust-conform type="fit" /><adjust-volume amount="2.4dB" /><asset-clip ref="r2" lane="1" offset="144000/24000s" name="Anchored Asset 1" /><asset-clip ref="r2" lane="1" offset="192000/24000s" name="Anchored Asset 2" /><marker start="120000/24000s" value="Marker 1" /><marker start="144000/24000s" value="Marker 2" /><chapter-marker start="168000/24000s" value="Chapter Marker" /><filter-video ref="r3" name="50s TV" /></asset-clip>
"""

    var testValue: AssetClip {
        var assetClip = AssetClip(referenceID: "r1", name: "Test Asset Clip", start: CMTime(seconds: 5, preferredTimescale: 24000))
        assetClip.note = "Test Note"
        assetClip.volume = Volume(amount: 2.4)
        assetClip.conform = Conform(type: .fit)
        var assetClip1 = AssetClip(referenceID: "r2", offset: CMTime(seconds: 6, preferredTimescale: 24000), name: "Anchored Asset 1")
        assetClip1.lane = 1
        var assetClip2 = AssetClip(referenceID: "r2", offset: CMTime(seconds: 8, preferredTimescale: 24000), name: "Anchored Asset 2")
        assetClip2.lane = 1
        assetClip.assetClips = [assetClip1, assetClip2]
        let marker1 = Marker(start: CMTime(seconds: 5, preferredTimescale: 24000), value: "Marker 1")
        let marker2 = Marker(start: CMTime(seconds: 6, preferredTimescale: 24000), value: "Marker 2")
        assetClip.markers = [marker1, marker2]
        let chapterMarker = ChapterMarker(start: CMTime(seconds: 7, preferredTimescale: 24000), value: "Chapter Marker")
        assetClip.chapterMarkers = [chapterMarker]
        var videoFilter = VideoFilter(effectID: "r3")
        videoFilter.name = "50s TV"
        assetClip.videoFilters = [videoFilter]
        return assetClip
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
        var assetClip = AssetClip(referenceID: "r1")
        XCTAssertNil(assetClip.metadata)
        assetClip.metadata = [metadatum]
        XCTAssertEqual(assetClip.metadata, [metadatum])
    }

    func testSetIsEnabled() {
        var assetClip = AssetClip(referenceID: "r1")
        XCTAssertTrue(assetClip.isEnabled)
        assetClip.isEnabled = false
        XCTAssertFalse(assetClip.isEnabled)
    }

    func testSetEnabledSource() {
        var assetClip = AssetClip(referenceID: "r1")
        XCTAssertEqual(assetClip.enabledSource, .all)
        assetClip.enabledSource = .video
        XCTAssertEqual(assetClip.enabledSource, .video)
    }

}

//
//  ClipTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class ClipTests: XCTestCase, FCPXMLTestCase {

    typealias T = Clip

    let rootKey = "clip"

    let xmlString = """
<clip offset="0/1s" name="Test Clip" start="120000/24000s" duration="480000/24000s"><note>Test Note</note><adjust-conform type="fit" /><adjust-volume amount="2.4dB" /><asset-clip ref="r2" lane="1" offset="144000/24000s" name="Anchored Asset 1" /><asset-clip ref="r2" lane="1" offset="192000/24000s" name="Anchored Asset 2" /><marker start="120000/24000s" value="Marker 1" /><marker start="144000/24000s" value="Marker 2" /><chapter-marker start="168000/24000s" value="Chapter Marker" /><filter-video ref="r3" name="50s TV" /><metadata><md key="Test Metadata" editable="1" displayName="Custom Metadata"><array><string>test1</string><string>test2</string></array></md></metadata></clip>
"""

    var testValue: Clip {
        var clip = Clip(duration: CMTime(seconds: 20, preferredTimescale: 24000))
        clip.note = "Test Note"
        clip.volume = Volume(amount: 2.4)
        clip.conform = Conform(type: .fit)
        clip.start = CMTime(seconds: 5, preferredTimescale: 24000)
        clip.name = "Test Clip"
        var assetClip1 = AssetClip(referenceID: "r2", offset: CMTime(seconds: 6, preferredTimescale: 24000), name: "Anchored Asset 1")
        assetClip1.lane = 1
        var assetClip2 = AssetClip(referenceID: "r2", offset: CMTime(seconds: 8, preferredTimescale: 24000), name: "Anchored Asset 2")
        assetClip2.lane = 1
        clip.assetClips = [assetClip1, assetClip2]
        let marker1 = Marker(start: CMTime(seconds: 5, preferredTimescale: 24000), value: "Marker 1")
        let marker2 = Marker(start: CMTime(seconds: 6, preferredTimescale: 24000), value: "Marker 2")
        clip.markers = [marker1, marker2]
        let chapterMarker = ChapterMarker(start: CMTime(seconds: 7, preferredTimescale: 24000), value: "Chapter Marker")
        clip.chapterMarkers = [chapterMarker]
        var videoFilter = VideoFilter(effectID: "r3")
        videoFilter.name = "50s TV"
        clip.videoFilters = [videoFilter]
        clip.metadata = [metadatum]
        return clip
    }

    private var metadatum: Metadatum {
        var metadatum = Metadatum(key: "Test Metadata")
        metadatum.array = ["test1", "test2"]
        metadatum.isEditable = true
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
        var clip = Clip(duration: CMTime(seconds: 20, preferredTimescale: 24000))
        XCTAssertNil(clip.metadata)
        clip.metadata = [metadatum]
        XCTAssertEqual(clip.metadata, [metadatum])
    }

    func testSetIsEnabled() {
        var clip = Clip(duration: CMTime(seconds: 20, preferredTimescale: 24000))
        XCTAssertTrue(clip.isEnabled)
        clip.isEnabled = false
        XCTAssertFalse(clip.isEnabled)
    }

}

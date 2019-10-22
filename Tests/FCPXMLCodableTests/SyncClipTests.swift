//
//  SyncClipTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class SyncClipTests: XCTestCase, FCPXMLTestCase {

    typealias T = SyncClip

    let rootKey = "sync-clip"

    let xmlString = """
<sync-clip offset="0/1s" name="Test Sync Clip" start="120000/24000s" duration="480000/24000s"><note>Test Note</note><adjust-conform type="fit" /><adjust-volume amount="2.4dB" /><asset-clip ref="r2" lane="1" offset="144000/24000s" name="Anchored Asset 1" /><asset-clip ref="r2" lane="1" offset="192000/24000s" name="Anchored Asset 2" /><marker start="120000/24000s" value="Marker 1" /><marker start="144000/24000s" value="Marker 2" /><chapter-marker start="168000/24000s" value="Chapter Marker" /><sync-source sourceID="connected"><audio-role-source role="dialogue" /></sync-source><sync-source sourceID="storyline"><audio-role-source role="music" /></sync-source></sync-clip>
"""

    var testValue: SyncClip {
        var clip = SyncClip(name: "Test Sync Clip", start: CMTime(seconds: 5, preferredTimescale: 24000),
                            duration: CMTime(seconds: 20, preferredTimescale: 24000))
        clip.note = "Test Note"
        clip.volume = Volume(amount: 2.4)
        clip.conform = Conform(type: .fit)
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
        let source1 = SyncSource(sourceID: .connected, audioRoleSources: [AudioRoleSource(role: "dialogue")])
        let source2 = SyncSource(sourceID: .storyline, audioRoleSources: [AudioRoleSource(role: "music")])
        clip.syncSources = [source1, source2]
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
        var clip = SyncClip(duration: CMTime(seconds: 20, preferredTimescale: 24000))
        XCTAssertNil(clip.metadata)
        clip.metadata = [metadatum]
        XCTAssertEqual(clip.metadata, [metadatum])
    }

    func testSetIsEnabled() {
        var clip = SyncClip(duration: CMTime(seconds: 20, preferredTimescale: 24000))
        XCTAssertTrue(clip.isEnabled)
        clip.isEnabled = false
        XCTAssertFalse(clip.isEnabled)
    }

}

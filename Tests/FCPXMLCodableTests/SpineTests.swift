//
//  SpineTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class SpineTests: XCTestCase, FCPXMLTestCase {

    typealias T = Spine

    let rootKey = "spine"

    let xmlString = """
<spine name="Blue Moon Spine"><asset-clip ref="r1" offset="0/1s" /><asset-clip ref="r2" offset="120000/24000s" /><audio ref="r4" offset="144000/24000s" duration="48000/24000s" /><title ref="r5" offset="144000/24000s" duration="48000/24000s" /><mc-clip ref="r6" offset="156000/24000s" duration="48000/24000s" /><video ref="r7" offset="168000/24000s" duration="48000/24000s" /><gap offset="240000/24000s" duration="48000/24000s" /><clip offset="264000/24000s" duration="48000/24000s" /><asset-clip ref="r3" offset="360000/24000s" /><audition offset="384000/24000s" /><transition offset="408000/24000s" duration="48000/24000s" /><ref-clip ref="r8" offset="432000/24000s" duration="48000/24000s" /><sync-clip offset="456000/24000s" duration="48000/24000s" /><gap offset="480000/24000s" duration="48000/24000s" /></spine>
"""

    var testValue: Spine {
        let duration = CMTime(seconds: 2, preferredTimescale: 24000)
        var spine = Spine()
        spine.name = "Blue Moon Spine"
        let assetClip1 = AssetClip(referenceID: "r1")
        let assetClip2 = AssetClip(referenceID: "r2", offset: CMTime(seconds: 5, preferredTimescale: 24000))
        let audio = Audio(referenceID: "r4", offset: CMTime(seconds: 6, preferredTimescale: 24000), duration: duration)
        let title = Title(referenceID: "r5", offset: CMTime(seconds: 6, preferredTimescale: 24000), duration: duration)
        let multicamClip = MulticamClip(referenceID: "r6", offset: CMTime(seconds: 6.5, preferredTimescale: 24000), duration: duration)
        let video = Video(referenceID: "r7", offset: CMTime(seconds: 7, preferredTimescale: 24000), duration: duration)
        let gap1 = Gap(offset: CMTime(seconds: 10, preferredTimescale: 24000), duration: duration)
        let assetClip3 = AssetClip(referenceID: "r3", offset: CMTime(seconds: 15, preferredTimescale: 24000))
        let clip = Clip(offset: CMTime(seconds: 11, preferredTimescale: 24000), duration: duration)
        let audition = Audition(offset: CMTime(seconds: 16, preferredTimescale: 24000))
        let transition = Transition(offset: CMTime(seconds: 17, preferredTimescale: 24000), duration: duration)
        let referenceClip = ReferenceClip(referenceID: "r8", offset: CMTime(seconds: 18, preferredTimescale: 24000), duration: duration)
        let syncClip = SyncClip(offset: CMTime(seconds: 19, preferredTimescale: 24000), duration: duration)
        let gap2 = Gap(offset: CMTime(seconds: 20, preferredTimescale: 24000), duration: duration)
        spine.assetClips = [assetClip1, assetClip2, assetClip3]
        spine.gaps = [gap1, gap2]
        spine.audios = [audio]
        spine.videos = [video]
        spine.titles = [title]
        spine.clips = [clip]
        spine.multicamClips = [multicamClip]
        spine.referenceClips = [referenceClip]
        spine.syncClips = [syncClip]
        spine.transitions = [transition]
        spine.auditions = [audition]
        return spine
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

//
//  ChapterMarker.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class ChapterMarkerTests: XCTestCase, FCPXMLTestCase {

    typealias T = ChapterMarker

    let rootKey = "chapter-marker"

    let xmlString = """
<chapter-marker start="168000/24000s" duration="120000/24000s" value="Chapter Marker" note="Note" posterOffset="48000/24000s" />
"""

    var testValue: ChapterMarker {
        var chapterMarker = ChapterMarker(start: CMTime(seconds: 7, preferredTimescale: 24000),
                                          duration: CMTime(seconds: 5, preferredTimescale: 24000), value: "Chapter Marker",
                                          posterOffset: CMTime(seconds: 2, preferredTimescale: 24000))
        chapterMarker.note = "Note"
        return chapterMarker
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

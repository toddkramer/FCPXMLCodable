//
//  AnalysisMarkerTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class AnalysisMarkerTests: XCTestCase, FCPXMLTestCase {

    typealias T = AnalysisMarker

    let rootKey = "analysis-marker"

    let xmlString = """
<analysis-marker start="120000/24000s" duration="480000/24000s"><shot-type value="closeUp" /><shot-type value="group" /><stabilization-type value="excessiveShake" /></analysis-marker>
"""

    var testValue: AnalysisMarker {
        var analysisMarker = AnalysisMarker()
        analysisMarker.start = CMTime(seconds: 5, preferredTimescale: 24000)
        analysisMarker.duration = CMTime(seconds: 20, preferredTimescale: 24000)
        analysisMarker.shotTypes = [ShotType(value: .closeUp), ShotType(value: .group)]
        analysisMarker.stabilizationTypes = [StabilizationType(value: .excessiveShake)]
        return analysisMarker
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

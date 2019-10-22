//
//  SmartCollectionTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XCTest
import FCPXMLCodable

final class SmartCollectionTests: XCTestCase, FCPXMLTestCase {

    typealias T = SmartCollection

    let rootKey = "smart-collection"

    let xmlString = """
<smart-collection name="Test Smart Collection" match="any"><match-text enabled="1" rule="includes" value="Test Match Text" /><match-ratings enabled="1" value="favorites" /><match-media enabled="1" rule="is" type="videoWithAudio" /><match-clip enabled="1" rule="is" type="project" /><match-stabilization enabled="1" rule="includesAny"><stabilization-type value="excessiveShake" /></match-stabilization><match-keywords enabled="1" rule="includesAny"><keyword-name value="Test 1" /><keyword-name value="Test 2" /></match-keywords><match-shot enabled="1" rule="includesAny"><shot-type value="closeUp" /><shot-type value="group" /></match-shot><match-property enabled="1" key="cameraName" rule="includes" value="Test Camera" /><match-time type="dateImported" rule="isAfter" value="2000-01-01 19:00:00 -0400" /><match-timeRange type="contentCreated" rule="isInLast" value="3" units="month" /><match-roles enabled="1" rule="includesAny"><role name="dialogue" /><role name="video" /></match-roles></smart-collection>
"""

    var testValue: SmartCollection {
        var smartCollection = SmartCollection(name: "Test Smart Collection", match: .any)
        smartCollection.matchClips = [MatchClip(type: .project)]
        smartCollection.matchKeywords = [MatchKeywords(keywordNames: [KeywordName(value: "Test 1"), KeywordName(value: "Test 2")])]
        smartCollection.matchMedias = [MatchMedia(type: .videoWithAudio)]
        smartCollection.matchRoles = [MatchRoles(roles: [Role(name: "dialogue"), Role(name: "video")])]
        smartCollection.matchShots = [MatchShot(shotTypes: [ShotType(value: .closeUp), ShotType(value: .group)])]
        smartCollection.matchTexts = [MatchText(value: "Test Match Text")]
        smartCollection.matchRatings = [MatchRatings(value: .favorites)]
        smartCollection.matchProperties = [MatchProperty(key: .cameraName, value: "Test Camera")]
        smartCollection.matchTimes = [MatchTime(type: .dateImported, rule: .isAfter, value: "2000-01-01 19:00:00 -0400")]
        smartCollection.matchTimeRanges = [MatchTimeRange(type: .contentCreated, rule: .isInLast, value: "3", units: .month)]
        smartCollection.matchStabilizations = [MatchStabilization(stabilizationTypes: [StabilizationType(value: .excessiveShake)])]
        return smartCollection
    }

    func testDecode() {
        evaluateDecodeTest()
    }

    func testEncode() {
        evaluateEncodeTest()
    }

}

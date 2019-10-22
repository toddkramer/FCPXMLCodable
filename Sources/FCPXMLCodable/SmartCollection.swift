//
//  SmartCollection.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/*
 <!ELEMENT smart-collection ((match-text | match-ratings | match-media | match-clip | match-stabilization | match-keywords | match-shot | match-property | match-time | match-timeRange | match-roles)*)>
 <!ATTLIST smart-collection name CDATA #REQUIRED>
 <!ATTLIST smart-collection match (any | all) #REQUIRED>
 */
public struct SmartCollection: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case matchTexts = "match-text"
        case matchRatings = "match-ratings"
        case matchMedias = "match-media"
        case matchClips = "match-clip"
        case matchStabilizations = "match-stabilization"
        case matchKeywords = "match-keywords"
        case matchShots = "match-shot"
        case matchProperties = "match-property"
        case matchTimes = "match-time"
        case matchTimeRanges = "match-timeRange"
        case matchRoles = "match-roles"
        case name, match
    }

    public enum MatchCriteria: String, Codable {
        case any, all
    }

    public var matchTexts: [MatchText] = []
    public var matchRatings: [MatchRatings] = []
    public var matchMedias: [MatchMedia] = []
    public var matchClips: [MatchClip] = []
    public var matchStabilizations: [MatchStabilization] = []
    public var matchKeywords: [MatchKeywords] = []
    public var matchShots: [MatchShot] = []
    public var matchProperties: [MatchProperty] = []
    public var matchTimes: [MatchTime] = []
    public var matchTimeRanges: [MatchTimeRange] = []
    public var matchRoles: [MatchRoles] = []

    public var name: String
    public var match: MatchCriteria

    public init(name: String, match: MatchCriteria) {
        self.name = name
        self.match = match
    }

}

extension SmartCollection: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .name, .match:
            return .attribute
        default:
            return .element
        }
    }

}

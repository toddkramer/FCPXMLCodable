//
//  SmartCollection.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder


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
    
    /// Specifies the possible match criteria modes for a smart collection.
    public enum MatchCriteria: String, Codable {

        /// :nodoc:
        case any

        /// :nodoc:
        case all

    }
    
    /// The text matches of the smart collection.
    public var matchTexts: [MatchText] = []
    
    /// The ratings matches of the smart collection.
    public var matchRatings: [MatchRatings] = []
    
    /// The media matches of the smart collection.
    public var matchMedias: [MatchMedia] = []
    
    /// The clip matches of the smart collection.
    public var matchClips: [MatchClip] = []
    
    /// The stabilization type matches of the smart collection.
    public var matchStabilizations: [MatchStabilization] = []
    
    /// The keywords matches of the smart collection.
    public var matchKeywords: [MatchKeywords] = []
    
    /// The shot type matches of the smart collection.
    public var matchShots: [MatchShot] = []
    
    /// The property matches of the smart collection.
    public var matchProperties: [MatchProperty] = []
    
    /// The time matches of the smart collection.
    public var matchTimes: [MatchTime] = []
    
    /// The time range matches of the smart collection.
    public var matchTimeRanges: [MatchTimeRange] = []
    
    /// The role matches of the smart collection.
    public var matchRoles: [MatchRoles] = []
    
    /// The name of the smart collection.
    public var name: String
    
    /// The match criteria to apply to the smart collection.
    public var match: MatchCriteria
    
    /// Initializes a new smart collection.
    /// - Parameter name: The name of the smart collection.
    /// - Parameter match: The match criteria to apply to the smart collection.
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

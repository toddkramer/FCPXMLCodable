//
//  SyncSource.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct SyncSource: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case audioRoleSources = "audio-role-source"
        case sourceID
    }
    
    /// Specifies the possible modes of a sync source.
    public enum Identifier: String, Codable {

        /// :nodoc:
        case storyline

        /// :nodoc:
        case connected

    }
    
    /// The audio role sources of the sync source.
    public var audioRoleSources: [AudioRoleSource] = []
    
    /// The source identifier of the sync source.
    public var sourceID: Identifier
    
    /// Initializes a new sync source.
    /// - Parameter sourceID: The source identifier of the sync source.
    /// - Parameter audioRoleSources: The audio role sources of the sync source.
    public init(sourceID: Identifier, audioRoleSources: [AudioRoleSource]) {
        self.sourceID = sourceID
        self.audioRoleSources = audioRoleSources
    }

}

extension SyncSource: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .audioRoleSources:
            return .element
        default:
            return .attribute
        }
    }

}

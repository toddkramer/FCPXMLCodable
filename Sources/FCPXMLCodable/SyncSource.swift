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

    public enum Identifier: String, Codable {
        case storyline, connected
    }

    public var audioRoleSources: [AudioRoleSource] = []
    public var sourceID: Identifier

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

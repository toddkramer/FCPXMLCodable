//
//  Event.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Event: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case clips = "clip"
        case auditions = "audition"
        case multicamClips = "mc-clip"
        case referenceClips = "ref-clip"
        case syncClips = "sync-clip"
        case assetClips = "asset-clip"
        case collectionFolders = "collection-folder"
        case keywordCollections = "keyword-collection"
        case smartCollections = "smart-collection"
        case projects = "project"
        case name, uid
    }

    public var clips: [Clip] = []
    public var auditions: [Audition] = []
    public var multicamClips: [MulticamClip] = []
    public var referenceClips: [ReferenceClip] = []
    public var syncClips: [SyncClip] = []
    public var assetClips: [AssetClip] = []
    public var collectionFolders: [CollectionFolder] = []
    public var keywordCollections: [KeywordCollection] = []
    public var smartCollections: [SmartCollection] = []
    public var projects: [Project] = []

    public var name: String?
    public var uid: String?

    public init(name: String? = nil, uid: String? = nil) {
        self.name = name
        self.uid = uid
    }

}

extension Event: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .name, .uid:
            return .attribute
        default:
            return .element
        }
    }

}

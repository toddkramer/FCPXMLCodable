//
//  Event.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Use a Final Cut Pro X event to store and organize clips and projects. You can import media files into a new or existing event. You can copy these
/// files into an event’s own media folder, or reference them in their original locations. Final Cut Pro X tracks each imported file as an asset and
/// ensures your event contains at least one clip per asset.
/// - SeeAlso:
/// [FCPXML Concepts](https://developer.apple.com/library/archive/documentation/FinalCutProX/Reference/FinalCutProXXMLFormat/EventsandProjects/EventsandProjects.html#//apple_ref/doc/uid/TP40011227-CH12-SW1)
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
    
    /// The clips contained in the event.
    public var clips: [Clip] = []
    
    /// The auditions contained in the event.
    public var auditions: [Audition] = []
    
    /// The multicam clips contained in the event.
    public var multicamClips: [MulticamClip] = []
    
    /// The reference clips contained in the event.
    public var referenceClips: [ReferenceClip] = []
    
    /// The sync clips contained in the event.
    public var syncClips: [SyncClip] = []
    
    /// The asset clips contained in the event.
    public var assetClips: [AssetClip] = []
    
    /// The collection folders contained in the event.
    public var collectionFolders: [CollectionFolder] = []
    
    /// The keyword collections contained in the event.
    public var keywordCollections: [KeywordCollection] = []
    
    /// The smart collections contained in the event.
    public var smartCollections: [SmartCollection] = []
    
    /// The projects contained in the event.
    public var projects: [Project] = []
    
    /// The name of the event.
    public var name: String?
    
    /// The unique identifier of the event.
    public var uid: String?
    
    /// Initializes a new event.
    /// - Parameter name: The name of the event.
    /// - Parameter uid: The unique identifier of the event.
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

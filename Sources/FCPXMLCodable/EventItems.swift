//
//  EventItems.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// A container for the possible event items that can be included in a FCPXML document. See `FCPXMLDocument.Configuration` for possible document
/// configurations.
public struct EventItems: Equatable {
    
    /// The clips to include in the FCPXMLDocument.
    public var clips: [Clip] = []

    /// The auditions to include in the FCPXMLDocument.
    public var auditions: [Audition] = []

    /// The multicam clips to include in the FCPXMLDocument.
    public var multicamClips: [MulticamClip] = []

    /// The reference clips to include in the FCPXMLDocument.
    public var referenceClips: [ReferenceClip] = []

    /// The sync clips to include in the FCPXMLDocument.
    public var syncClips: [SyncClip] = []

    /// The asset clips to include in the FCPXMLDocument.
    public var assetClips: [AssetClip] = []

    /// The collection folders to include in the FCPXMLDocument.
    public var collectionFolders: [CollectionFolder] = []

    /// The keyword collections to include in the FCPXMLDocument.
    public var keywordCollections: [KeywordCollection] = []

    /// The smart collections to include in the FCPXMLDocument.
    public var smartCollections: [SmartCollection] = []

    /// The projects to include in the FCPXMLDocument.
    public var projects: [Project] = []

    /// :nodoc:
    public init() {}

}

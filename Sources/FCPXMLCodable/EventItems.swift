//
//  EventItems.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

public struct EventItems: Equatable {

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

    public init() {}

}

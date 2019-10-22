//
//  CollectionFolder.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct CollectionFolder: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case collectionFolders = "collection-folder"
        case keywordCollections = "keyword-collection"
        case smartCollections = "smart-collection"
        case name
    }

    public var collectionFolders: [CollectionFolder] = []
    public var keywordCollections: [KeywordCollection] = []
    public var smartCollections: [SmartCollection] = []

    public var name: String

    public init(name: String) {
        self.name = name
    }

}

extension CollectionFolder: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .collectionFolders, .keywordCollections, .smartCollections:
            return .element
        default:
            return .attribute
        }
    }

}

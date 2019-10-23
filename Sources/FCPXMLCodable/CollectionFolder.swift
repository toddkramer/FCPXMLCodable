//
//  CollectionFolder.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// A container to group other collection elements.
public struct CollectionFolder: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case collectionFolders = "collection-folder"
        case keywordCollections = "keyword-collection"
        case smartCollections = "smart-collection"
        case name
    }
    
    /// The collection subfolders contained in the collection folder.
    public var collectionFolders: [CollectionFolder] = []
    
    /// The keyword collections contained in the collection folder.
    public var keywordCollections: [KeywordCollection] = []
    
    /// The smart collections contained in the collection folder.
    public var smartCollections: [SmartCollection] = []
    
    /// The name of the collection folder.
    public var name: String
    
    /// Initializes a new collection folder.
    /// - Parameter name: The name of the collection folder.
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

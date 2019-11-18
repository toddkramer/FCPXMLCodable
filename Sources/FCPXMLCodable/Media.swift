//
//  Media.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation
import XMLCoder

public struct Media: Resource {

    private enum CodingKeys: String, CodingKey {
        case multicam, sequence
        case id, name, uid
        case dateModified = "modDate"
        case projectID = "projectRef"
    }
    
    /// The multicam contained in the media.
    public var multicam: Multicam?
    
    /// The sequence contained in the media.
    public var sequence: Sequence?

    /// The identifier of the media.
    /// This identifier is unique within the context of a FCPXML document and refers to the resource identifier (e.g. r1).
    public let id: String
    
    /// The name of the media.
    public var name: String?
    
    /// The unique identifier of the media.
    public var uid: String?
    
    /// The identifier of the associated project.
    public var projectID: String?
    
    /// The date modified of the media.
    public var dateModified: Date?
    
    /// Initializes a new media with a resource identifier.
    /// - Parameter id: The identifier of the media.
    /// - Parameter name: The name of the media.
    /// - Parameter uid: The unique identifier of the media.
    /// - Parameter dateModified: The date modified of the media.
    public init(id: String, name: String? = nil, uid: String? = nil, dateModified: Date? = nil) {
        self.id = id
        self.name = name
        self.uid = uid
        self.dateModified = dateModified
    }

}

extension Media: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? Media.CodingKeys else { return .element }
        switch key {
        case .multicam, .sequence:
            return .element
        default:
            return .attribute
        }
    }

}

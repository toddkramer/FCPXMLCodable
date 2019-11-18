//
//  Project.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation
import XMLCoder

public struct Project: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case sequence
        case name, uid, id
        case dateModified = "modDate"
    }
    
    /// The sequence contained in the project.
    public var sequence: Sequence
    
    /// The name of the project.
    public var name: String?
    
    /// The unique identifier of the project.
    public var uid: String?
    
    /// The identifier of the project.
    public var id: String?
    
    /// The date modified of the project.
    public var dateModified: Date?
    
    /// Initializes a new project.
    /// - Parameter name: The name of the project.
    /// - Parameter uid: The unique identifer of the project.
    /// - Parameter dateModified: The date modified of the project.
    /// - Parameter sequence: The sequence contained in the project.
    public init(name: String? = nil, uid: String? = nil, dateModified: Date? = nil, sequence: Sequence) {
        self.name = name
        self.uid = uid
        self.dateModified = dateModified
        self.sequence = sequence
    }

}

extension Project: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .sequence:
            return .element
        default:
            return .attribute
        }
    }

}

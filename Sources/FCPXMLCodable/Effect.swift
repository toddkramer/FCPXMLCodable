//
//  Effect.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// A reference to an effect plug-in (for example, FxPlug, Motion document, or Audio Unit). The `sourceURL` property specifies the location of a
/// Motion template, when templates are managed in the library or another external location.
/// - SeeAlso:
/// [FCPXML Resources Documentation](https://developer.apple.com/library/archive/documentation/FinalCutProX/Reference/FinalCutProXXMLFormat/Resources/Resources.html#//apple_ref/doc/uid/TP40011227-CH16-SW1)
public struct Effect: Resource {

    private enum CodingKeys: String, CodingKey {
        case id, name, uid, sourceURL = "src"
    }

    /// The identifier of the effect.
    /// This identifier is unique within the context of a FCPXML document and refers to the resource identifier (e.g. r1).
    public let id: String
    
    /// The name of the effect.
    public var name: String?
    
    /// The unique identifier of the effect.
    public var uid: String
    
    /// The source URL of the effect.
    public var sourceURL: String?
    
    /// Initializes a new effect.
    /// - Parameter id: The identifier of the effect.
    /// - Parameter name: The name of the effect.
    /// - Parameter uid: The unique identifier of the effect.
    public init(id: String, name: String? = nil, uid: String) {
        self.id = id
        self.name = name
        self.uid = uid
    }

}

extension Effect: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

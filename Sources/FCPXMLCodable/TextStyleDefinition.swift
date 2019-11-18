//
//  TextStyleDefinition.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct TextStyleDefinition: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case textStyles = "text-style"
        case id, name
    }
    
    /// The text styles of the text style definition.
    public var textStyles: [TextStyle] = []
    
    /// The identifier of the text style definition.
    public let id: String
    
    /// The name of the text style definition.
    public var name: String?
    
    /// Initializes a new text style definition.
    /// - Parameter id: The identifier of the text style definition.
    public init(id: String) {
        self.id = id
    }

}

extension TextStyleDefinition: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .textStyles:
            return .element
        default:
            return .attribute
        }
    }

}

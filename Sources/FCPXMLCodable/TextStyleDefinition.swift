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

    public var textStyles: [TextStyle] = []
    public let id: String
    public var name: String?

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

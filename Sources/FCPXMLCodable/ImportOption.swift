//
//  ImportOption.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct ImportOption: XMLRepresentable {

    public let key: String
    public let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }

}

extension ImportOption: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

public struct ImportOptions: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case importOptions = "option"
    }

    public let importOptions: [ImportOption]

    public init?(importOptions: [ImportOption]?) {
        guard let importOptions = importOptions else { return nil }
        self.importOptions = importOptions
    }

}

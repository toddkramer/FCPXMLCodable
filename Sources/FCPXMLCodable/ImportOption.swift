//
//  ImportOption.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct ImportOption: XMLRepresentable {
    
    /// The key of the import option.
    public let key: String
    
    /// The value of the import option.
    public let value: String
    
    /// Initializes a new import option.
    /// - Parameter key: The key of the import option.
    /// - Parameter value: The value of the import option.
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

/// A container for a set of import options.
public struct ImportOptions: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case importOptions = "option"
    }
    
    /// The import options to be used when opening a FCPXML document in Final Cut Pro X.
    public let importOptions: [ImportOption]
    
    /// Initializes a new import options container.
    /// - Parameter importOptions: The import options included in the container.
    public init?(importOptions: [ImportOption]?) {
        guard let importOptions = importOptions else { return nil }
        self.importOptions = importOptions
    }

}

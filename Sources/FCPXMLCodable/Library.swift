//
//  Library.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Library: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case events = "event"
        case smartCollections = "smart-collection"
        case location
        case colorProcessing
    }
    
    /// Specifies the possible color processing modes of a library.
    public enum ColorProcessing: String, Codable {

        /// :nodoc:
        case standard

        /// :nodoc:
        case wide

        /// :nodoc:
        case wideHDR = "wide-hdr"

    }
    
    /// The events contained in the library.
    public var events: [Event] = []
    
    /// The smart collections contained in the library.
    public var smartCollections: [SmartCollection] = []
    
    /// The location of the library.
    public var location: String?
    
    /// The color processing mode of the library.
    public var colorProcessing: ColorProcessing?
    
    /// Initializes a new library.
    /// - Parameter location: The location of the library.
    public init(location: String? = nil) {
        self.location = location
    }

}

extension Library: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .events, .smartCollections:
            return .element
        default:
            return .attribute
        }
    }

}

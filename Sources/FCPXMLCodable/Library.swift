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

    public enum ColorProcessing: String, Codable {
        case standard
        case wide
        case wideHDR = "wide-hdr"
    }

    public var events: [Event] = []
    public var smartCollections: [SmartCollection] = []

    public var location: String?
    public var colorProcessing: ColorProcessing?

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

//
//  Metadatum.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Enumerates the metadatum value types supported in FCPX.
public enum MetadatumType: String, Codable, Equatable {

    /// :nodoc:
    case string

    /// :nodoc:
    case boolean

    /// :nodoc:
    case integer

    /// :nodoc:
    case float

    /// :nodoc:
    case date

    /// :nodoc:
    case timecode

}

public struct Metadatum: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case _array = "array"
        case key, value, editable, type, displayName, description, source
    }

    public var array: [String]? {
        get { return _array?.strings }
        set { _array = StringsContainer(strings: newValue) }
    }

    public var key: String
    public var value: String?
    public var isEditable: Bool {
        get { return editable ?? false }
        set { editable = newValue }
    }
    public var type: MetadatumType?
    public var displayName: String?
    public var description: String?
    public var source: String?

    private var _array: StringsContainer?
    private var editable: Bool?

    public init(key: String, value: String? = nil) {
        self.key = key
        self.value = value
    }

}

extension Metadatum: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? Metadatum.CodingKeys else { return .element }
        switch key {
        case ._array:
            return .element
        default:
            return .attribute
        }
    }

}

extension Metadatum {

    struct StringsContainer: Codable, Equatable {

        private enum CodingKeys: String, CodingKey {
            case strings = "string"
        }

        var strings: [String]

        init?(strings: [String]?) {
            guard let strings = strings else { return nil }
            self.strings = strings
        }

    }
}

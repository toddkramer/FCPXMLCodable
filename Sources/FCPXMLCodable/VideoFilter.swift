//
//  VideoFilter.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct VideoFilter: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case data
        case parameters = "param"
        case effectID = "ref"
        case name, enabled
    }

    public var data: KeyedData?
    public var parameters: [Parameter] = []

    public let effectID: String
    public var name: String?
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    private var enabled: Bool?

    public init(effectID: String, name: String? = nil) {
        self.effectID = effectID
        self.name = name
    }

}

extension VideoFilter: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .data, .parameters:
            return .element
        default:
            return .attribute
        }
    }

}

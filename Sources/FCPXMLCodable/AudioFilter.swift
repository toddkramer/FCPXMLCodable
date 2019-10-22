//
//  AudioFilter.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// A reference to an audio effect.
public struct AudioFilter: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case data
        case parameters = "param"
        case effectID = "ref"
        case name, enabled, presetID
    }

    /// The data associated with the audio filter.
    public var data: KeyedData?

    /// The parameters associated with the audio filter.
    public var parameters: [Parameter] = []

    /// The identifier of the `Effect` referenced by this audio filter.
    public let effectID: String

    /// The name of the audio filter.
    public var name: String?

    /// A Boolean value indicating whether the audio filter is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    /// The preset identifier of the audio filter.
    public var presetID: String?

    private var enabled: Bool?
    
    /// Initializes a new audio filter with an effect identifier.
    /// - Parameter effectID: The identifier of the `Effect` referenced by this audio filter.
    /// - Parameter name: The name of the audio filter.
    public init(effectID: String, name: String? = nil) {
        self.effectID = effectID
        self.name = name
    }

}

extension AudioFilter: DynamicNodeEncoding {

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

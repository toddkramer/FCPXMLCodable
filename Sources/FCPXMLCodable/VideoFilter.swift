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
    
    /// The data associated with the video filter.
    public var data: KeyedData?
    
    /// The parameters associated with the video filter.
    public var parameters: [Parameter] = []
    
    /// The identifier of the `Effect` resource referenced by this video filter.
    public let effectID: String
    
    /// The name of the video filter.
    public var name: String?
    
    /// A Boolean value indicating whether the video filter is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    private var enabled: Bool?
    
    /// Initializes a new video filter.
    /// - Parameter effectID: The identifier of the `Effect` resource referenced by this video filter.
    /// - Parameter name: The name of the video filter.
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

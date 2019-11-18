//
//  MaskShape.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MaskShape: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case name, enabled
        case _blendMode = "blendMode"
    }
    
    /// The parameters associated with the mask shape.
    public var parameters: [Parameter] = []
    
    /// The name of the mask shape.
    public var name: String?
    
    /// A Boolean value indicating whether the mask shape is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// The blend mode of the mask shape.
    public var blendMode: BlendMode {
        get { return _blendMode ?? .add }
        set { _blendMode = newValue }
    }

    private var enabled: Bool?
    private var _blendMode: BlendMode?
    
    /// Initializes a new mask shape.
    /// - Parameter name: The name of the mask shape.
    /// - Parameter blendMode: The blend mode of the mask shape.
    public init(name: String? = nil, blendMode: BlendMode = .add) {
        self.name = name
        self._blendMode = blendMode
    }

}

extension MaskShape: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .parameters:
            return .element
        default:
            return .attribute
        }
    }

}

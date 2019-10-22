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

    public var parameters: [Parameter] = []

    public var name: String?
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var blendMode: BlendMode {
        get { return _blendMode ?? .add }
        set { _blendMode = newValue }
    }

    private var enabled: Bool?
    private var _blendMode: BlendMode?

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

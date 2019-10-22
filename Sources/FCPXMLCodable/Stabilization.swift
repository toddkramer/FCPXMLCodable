//
//  Stabilization.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Stabilization: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case _type = "type"
    }

    public enum Mode: String, XMLRepresentable {
        case automatic, inertiaCam, smoothCam
    }

    public var parameters: [Parameter] = []

    public var type: Mode {
        get { return _type ?? .automatic }
        set { _type = newValue }
    }

    private var _type: Mode?

    public init(type: Mode = .automatic) {
        self._type = type
    }

}

extension Stabilization: DynamicNodeEncoding {

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

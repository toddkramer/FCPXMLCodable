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
    
    /// Specifies the possible modes of a stabilization adjustment.
    public enum Mode: String, XMLRepresentable {

        /// :nodoc:
        case automatic

        /// :nodoc:
        case inertiaCam

        /// :nodoc:
        case smoothCam

    }
    
    /// The parameters associated with the stabilization adjustment.
    public var parameters: [Parameter] = []
    
    /// The type of the stabilization adjustment.
    public var type: Mode {
        get { return _type ?? .automatic }
        set { _type = newValue }
    }

    private var _type: Mode?
    
    /// Initializes a stabilization adjustment.
    /// - Parameter type: The type of the stabilization adjustment, `automatic` by default.
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

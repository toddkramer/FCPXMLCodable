//
//  StabilizationType.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct StabilizationType: XMLRepresentable {
    
    /// Specifies the possible stabilization type values to use in a stabilization type match or analysis marker.
    public enum Value: String, XMLRepresentable {

        /// :nodoc:
        case excessiveShake

    }
    
    /// The value of the stabilization type.
    public var value: Value
    
    /// Initializes a new stabilization type.
    /// - Parameter value: The value of the stabilization type.
    public init(value: Value) {
        self.value = value
    }

}

extension StabilizationType: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

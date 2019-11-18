//
//  Keyframe.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Keyframe: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case time, value, curve
        case interpolation = "interp"
    }
    
    /// Specifies the possible interpolation modes that can be used in an individual keyframe of a keyframe animation.
    public enum Interpolation: String, Codable {

        /// :nodoc:
        case linear

        /// :nodoc:
        case ease

        /// :nodoc:
        case easeIn

        /// :nodoc:
        case easeOut

    }
    
    /// Specifies the possible curves that can be used in an individual keyframe of a keyframe animation.
    public enum Curve: String, Codable {

        /// :nodoc:
        case linear

        /// :nodoc:
        case smooth

    }
    
    /// The time of the keyframe.
    public var time: CMTime
    
    /// The value of the keyframe.
    public var value: String
    
    /// The interpolation mode to use for the keyframe.
    public var interpolation: Interpolation
    
    /// The curve to use for the keyframe.
    public var curve: Curve
    
    /// Initializes a new keyframe.
    /// - Parameter time: The time of the keyframe.
    /// - Parameter value: The value of the keyframe.
    /// - Parameter interpolation: The interpolation mode to use for the keyframe, `linear` by default.
    /// - Parameter curve: The curve to use for the keyframe, `smooth` by default.
    public init(time: CMTime, value: String, interpolation: Interpolation = .linear, curve: Curve = .smooth) {
        self.time = time
        self.value = value
        self.interpolation = interpolation
        self.curve = curve
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        time = try container.decode(CMTime.self, forKey: .time)
        value = try container.decode(String.self, forKey: .value)
        interpolation = try container.decodeIfPresent(Interpolation.self, forKey: .interpolation) ?? .linear
        curve = try container.decodeIfPresent(Curve.self, forKey: .curve) ?? .smooth
    }

}

extension Keyframe: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

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

    public enum Interpolation: String, Codable {
        case linear, ease, easeIn, easeOut
    }

    public enum Curve: String, Codable {
        case linear, smooth
    }

    public var time: CMTime
    public var value: String
    public var interpolation: Interpolation
    public var curve: Curve

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

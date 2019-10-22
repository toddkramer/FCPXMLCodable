//
//  Orientation.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Orientation: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case isEnabled = "enabled"
        case tilt, pan, roll, fieldOfView
    }

    public var parameters: [Parameter] = []

    public var isEnabled: Bool = true
    public var tilt: Double
    public var pan: Double
    public var roll: Double
    public var fieldOfView: Double?

    public init(tilt: Double, pan: Double, roll: Double, fieldOfView: Double? = nil) {
        self.tilt = tilt
        self.pan = pan
        self.roll = roll
        self.fieldOfView = fieldOfView
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        tilt = try container.decodeIfPresent(Double.self, forKey: .tilt) ?? 0
        pan = try container.decodeIfPresent(Double.self, forKey: .pan) ?? 0
        roll = try container.decodeIfPresent(Double.self, forKey: .roll) ?? 0
        fieldOfView = try container.decodeIfPresent(Double.self, forKey: .fieldOfView)
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }

}

extension Orientation: DynamicNodeEncoding {

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

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
    
    /// The parameters associated with the orientation adjustment.
    public var parameters: [Parameter] = []
    
    /// A Boolean value indicating whether the orientation adjustment is enabled.
    public var isEnabled: Bool = true
    
    /// The tilt of the orientation adjustment.
    public var tilt: Double
    
    /// The pan of the orientation adjustment.
    public var pan: Double
    
    /// The roll of the orientation adjustment.
    public var roll: Double
    
    /// The field of view of the orientation adjustment.
    public var fieldOfView: Double?
    
    /// Initializes a new orientation adjustment.
    /// - Parameter tilt: The tilt of the orientation adjustment.
    /// - Parameter pan: The pan of the orientation adjustment.
    /// - Parameter roll: The roll of the orientation adjustment.
    /// - Parameter fieldOfView: The field of view of the orientation adjustment.
    public init(tilt: Double, pan: Double, roll: Double, fieldOfView: Double? = nil) {
        self.tilt = tilt
        self.pan = pan
        self.roll = roll
        self.fieldOfView = fieldOfView
    }

    /// :nodoc:
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

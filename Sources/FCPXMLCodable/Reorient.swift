//
//  Reorient.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Reorient: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case isEnabled = "enabled"
        case tilt, pan, roll, convergence
    }
    
    /// The parameters associated with the reorient adjustment.
    public var parameters: [Parameter] = []
    
    /// A Boolean value indicating whether the reorient adjustment is enabled.
    public var isEnabled: Bool = true
    
    /// The tilt of the reorient adjustment.
    public var tilt: Double
    
    /// The pan of the reorient adjustment.
    public var pan: Double
    
    /// The roll of the reorient adjustment.
    public var roll: Double
    
    /// The convergence of the reorient adjustment.
    public var convergence: Double
    
    /// Initializes a new reorient adjustment.
    /// - Parameter tilt: The tilt of the reorient adjustment.
    /// - Parameter pan: The pan of the reorient adjustment.
    /// - Parameter roll: The roll of the reorient adjustment.
    /// - Parameter convergence: The convergence of the reorient adjustment.
    public init(tilt: Double, pan: Double, roll: Double, convergence: Double) {
        self.tilt = tilt
        self.pan = pan
        self.roll = roll
        self.convergence = convergence
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        tilt = try container.decodeIfPresent(Double.self, forKey: .tilt) ?? 0
        pan = try container.decodeIfPresent(Double.self, forKey: .pan) ?? 0
        roll = try container.decodeIfPresent(Double.self, forKey: .roll) ?? 0
        convergence = try container.decodeIfPresent(Double.self, forKey: .convergence) ?? 0
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }

}

extension Reorient: DynamicNodeEncoding {

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

//
//  Transform360.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Transform360: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case enabled, latitude, longitude, distance, xPosition, yPosition, zPosition, xOrientation, yOrientation, zOrientation
        case convergence, interaxial
        case coordinateType = "coordinates"
        case _autoOrient = "autoOrient"
    }
    
    /// Specifies the possible coordinate types in a 360 transform adjustment.
    public enum CoordinateType: String, Codable {

        /// :nodoc:
        case spherical

        /// :nodoc:
        case cartesian

    }
    
    /// The parameters associated with the 360 transform adjustment.
    public var parameters: [Parameter] = []
    
    /// A Boolean value indicating whether the 360 transform adjustment is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// The coordinate type of the 360 transform adjustment.
    public var coordinateType: CoordinateType
    
    /// The latitude of the 360 transform adjustment.
    public var latitude: Double?
    
    /// The longitude of the 360 transform adjustment.
    public var longitude: Double?
    
    /// The distance of the 360 transform adjustment.
    public var distance: Double?
    
    /// The x position of the 360 transform adjustment.
    public var xPosition: Double?
    
    /// The y postion of the 360 transform adjustment.
    public var yPosition: Double?
    
    /// The z position of the 360 transform adjustment.
    public var zPosition: Double?
    
    /// The x orientation of the 360 transform adjustment.
    public var xOrientation: Double?
    
    /// The y orientation of the 360 transform adjustment.
    public var yOrientation: Double?
    
    /// The z orientation of the 360 transform adjustment.
    public var zOrientation: Double?
    
    /// A Boolean value indicating whether auto orientation is enabled.
    public var autoOrient: Bool {
        get { return _autoOrient ?? true }
        set { _autoOrient = newValue }
    }
    
    /// The convergence of the 360 transform adjustment.
    public var convergence: Double?
    
    /// The interaxial of the 360 transform adjustment.
    public var interaxial: Double?

    private var enabled: Bool?
    private var _autoOrient: Bool?
    
    /// Initializes a new 360 transform adjustment.
    /// - Parameter coordinateType: The coordinate type of the 360 transform adjustment.
    public init(coordinateType: CoordinateType) {
        self.coordinateType = coordinateType
    }

}

extension Transform360: DynamicNodeEncoding {

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

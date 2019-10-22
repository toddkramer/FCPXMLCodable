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

    public enum CoordinateType: String, Codable {
        case spherical, cartesian
    }

    public var parameters: [Parameter] = []

    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var coordinateType: CoordinateType
    public var latitude: Double?
    public var longitude: Double?
    public var distance: Double?
    public var xPosition: Double?
    public var yPosition: Double?
    public var zPosition: Double?
    public var xOrientation: Double?
    public var yOrientation: Double?
    public var zOrientation: Double?
    public var autoOrient: Bool {
        get { return _autoOrient ?? true }
        set { _autoOrient = newValue }
    }
    public var convergence: Double?
    public var interaxial: Double?

    private var enabled: Bool?
    private var _autoOrient: Bool?

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

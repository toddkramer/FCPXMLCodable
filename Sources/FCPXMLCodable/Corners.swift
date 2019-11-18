//
//  Corners.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Modifies the corners of the visible image, adding a distort (or skew) effect using the `bottomLeft`, `topLeft`, `topRight`, and `bottomRight`
///  properties. These attributes are two-dimensional point values expressed as a percentage of frame height.
/// - SeeAlso:
/// [FCPXML Adjustments And Effects](https://developer.apple.com/library/archive/documentation/FinalCutProX/Reference/FinalCutProXXMLFormat/Adjustments/Adjustments.html#//apple_ref/doc/uid/TP40011227-CH14-SW1)
public struct Corners: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case isEnabled = "enabled"
        case bottomLeft = "botLeft"
        case topLeft
        case topRight
        case bottomRight = "botRight"
    }
    
    /// The parameters associated with the corners adjustment.
    public var parameters: [Parameter] = []

    /// A Boolean value that indicates whether the corners adjustment is enabled.
    public var isEnabled: Bool = true
    
    /// The bottom left point of the corners adjustment.
    public var bottomLeft: Point
    
    /// The top left point of the corners adjustment.
    public var topLeft: Point
    
    /// The top right point of the corners adjustment.
    public var topRight: Point
    
    /// The bottom right point of the corners adjustment.
    public var bottomRight: Point
    
    /// Initializes a new corners adjustment.
    /// - Parameter bottomLeft: /// The bottom left point of the corners adjustment.
    /// - Parameter topLeft: /// The top left point of the corners adjustment.
    /// - Parameter topRight: /// The top right point of the corners adjustment.
    /// - Parameter bottomRight: /// The bottom right point of the corners adjustment.
    public init(bottomLeft: Point, topLeft: Point, topRight: Point, bottomRight: Point) {
        self.bottomLeft = bottomLeft
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomRight = bottomRight
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        bottomLeft = try container.decodeIfPresent(Point.self, forKey: .bottomLeft) ?? .zero
        topLeft = try container.decodeIfPresent(Point.self, forKey: .topLeft) ?? .zero
        topRight = try container.decodeIfPresent(Point.self, forKey: .topRight) ?? .zero
        bottomRight = try container.decodeIfPresent(Point.self, forKey: .bottomRight) ?? .zero
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }

}

extension Corners: DynamicNodeEncoding {

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

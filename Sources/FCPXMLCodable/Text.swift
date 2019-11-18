//
//  Text.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Text: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case value = ""
        case textStyles = "text-style"
        case displayStyle = "display-style"
        case rollUpHeight = "roll-up-height"
        case position
        case placement
        case alignment
    }
    
    /// Specifies the possible display styles of a text element.
    public enum DisplayStyle: String, Codable {

        /// :nodoc:
        case popOn = "pop-on"

        /// :nodoc:
        case paintOn = "paint-on"

        /// :nodoc:
        case rollUp = "roll-up"

    }
    
    /// Specifies the possible placements of a text element.
    public enum Placement: String, Codable {

        /// :nodoc:
        case left

        /// :nodoc:
        case right

        /// :nodoc:
        case top

        /// :nodoc:
        case bottom

    }
    
    /// The value of the text.
    public var value: String?
    
    /// The text styles of the text.
    public var textStyles: [TextStyle] = []
    
    /// The display style of the text.
    public var displayStyle: DisplayStyle?
    
    /// The roll up height of the text.
    public var rollUpHeight: Double?
    
    /// The position of the text.
    public var position: Point?
    
    /// The placement of the text.
    public var placement: Placement
    
    /// The alignment of the text.
    public var alignment: TextAlignment?
    
    /// Initializes a new text.
    /// - Parameter placement: The placement of the text, `bottom` by default.
    public init(placement: Placement = .bottom) {
        self.placement = placement
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try? container.decode(String.self, forKey: .value)
        textStyles = try container.decode([TextStyle].self, forKey: .textStyles)
        displayStyle = try container.decodeIfPresent(DisplayStyle.self, forKey: .displayStyle)
        rollUpHeight = try container.decodeIfPresent(Double.self, forKey: .rollUpHeight)
        position = try container.decodeIfPresent(Point.self, forKey: .position)
        placement = try container.decodeIfPresent(Placement.self, forKey: .placement) ?? .bottom
        alignment = try container.decodeIfPresent(TextAlignment.self, forKey: .alignment)
    }

}

extension Text: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .value, .textStyles:
            return .element
        default:
            return .attribute
        }
    }

}

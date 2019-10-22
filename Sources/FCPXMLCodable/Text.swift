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

    public enum DisplayStyle: String, Codable {
        case popOn = "pop-on"
        case paintOn = "paint-on"
        case rollUp = "roll-up"
    }

    public enum Placement: String, Codable {
        case left, right, top, bottom
    }

    public var value: String?
    public var textStyles: [TextStyle] = []

    public var displayStyle: DisplayStyle?
    public var rollUpHeight: Double?
    public var position: Point?
    public var placement: Placement
    public var alignment: TextAlignment?

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

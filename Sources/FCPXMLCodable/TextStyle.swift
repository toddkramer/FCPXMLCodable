//
//  TextStyle.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct TextStyle: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case value = ""
        case parameters = "param"
        case referenceID = "ref"
        case font, fontSize, fontFace
        case _fontColor = "fontColor"
        case _backgroundColor = "backgroundColor"
        case isBold = "bold"
        case isItalic = "italic"
        case _strokeColor = "strokeColor"
        case strokeWidth, baseline
        case _shadowColor = "shadowColor"
        case shadowOffset, shadowBlurRadius, kerning, alignment, lineSpacing, tabStops, baselineOffset
        case isUnderlined = "underline"
    }

    public var value: String?
    public var parameters: [Parameter] = []

    public var referenceID: String?
    public var font: String?
    public var fontSize: Int?
    public var fontFace: String?
    public var fontColor: Color? {
        get { return _fontColor?.colorValue }
        set { _fontColor = newValue?.stringValue }
    }
    public var backgroundColor: Color? {
        get { return _backgroundColor?.colorValue }
        set { _backgroundColor = newValue?.stringValue }
    }
    public var isBold: Bool?
    public var isItalic: Bool?
    public var strokeColor: Color? {
        get { return _strokeColor?.colorValue }
        set { _strokeColor = newValue?.stringValue }
    }
    public var strokeWidth: Double?
    public var baseline: Double?
    public var shadowColor: Color? {
        get { return _shadowColor?.colorValue }
        set { _shadowColor = newValue?.stringValue }
    }
    public var shadowOffset: Double?
    public var shadowBlurRadius: Double?
    public var kerning: Double?
    public var alignment: TextAlignment?
    public var lineSpacing: Double?
    public var tabStops: Double?
    public var baselineOffset: Double?
    public var isUnderlined: Bool?

    private var _fontColor: String?
    private var _backgroundColor: String?
    private var _strokeColor: String?
    private var _shadowColor: String?

    public init(referenceID: String? = nil, value: String? = nil) {
        self.referenceID = referenceID
        self.value = value
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try? container.decode(String.self, forKey: .value)
        parameters = try container.decode([Parameter].self, forKey: .parameters)
        referenceID = try container.decodeIfPresent(String.self, forKey: .referenceID)
        font = try container.decodeIfPresent(String.self, forKey: .font)
        fontSize = try container.decodeIfPresent(Int.self, forKey: .fontSize)
        fontFace = try container.decodeIfPresent(String.self, forKey: .fontFace)
        _fontColor = try container.decodeIfPresent(String.self, forKey: ._fontColor)
        _backgroundColor = try container.decodeIfPresent(String.self, forKey: ._backgroundColor)
        isBold = try container.decodeIfPresent(Bool.self, forKey: .isBold)
        isItalic = try container.decodeIfPresent(Bool.self, forKey: .isItalic)
        _strokeColor = try container.decodeIfPresent(String.self, forKey: ._strokeColor)
        strokeWidth = try container.decodeIfPresent(Double.self, forKey: .strokeWidth)
        baseline = try container.decodeIfPresent(Double.self, forKey: .baseline)
        _shadowColor = try container.decodeIfPresent(String.self, forKey: ._shadowColor)
        shadowOffset = try container.decodeIfPresent(Double.self, forKey: .shadowOffset)
        shadowBlurRadius = try container.decodeIfPresent(Double.self, forKey: .shadowBlurRadius)
        kerning = try container.decodeIfPresent(Double.self, forKey: .kerning)
        alignment = try container.decodeIfPresent(TextAlignment.self, forKey: .alignment)
        lineSpacing = try container.decodeIfPresent(Double.self, forKey: .lineSpacing)
        tabStops = try container.decodeIfPresent(Double.self, forKey: .tabStops)
        baselineOffset = try container.decodeIfPresent(Double.self, forKey: .baselineOffset)
        isUnderlined = try container.decodeIfPresent(Bool.self, forKey: .isUnderlined)
    }

}

extension TextStyle: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .value, .parameters:
            return .element
        default:
            return .attribute
        }
    }

}

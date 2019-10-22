//
//  Parameter.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Parameter: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case fadeIn, fadeOut, keyframeAnimation
        case parameters = "param"
        case name, key, value, enabled
    }

    public var fadeIn: FadeIn?
    public var fadeOut: FadeOut?
    public var keyframeAnimation: KeyframeAnimation?
    public var parameters: [Parameter] = []

    public var name: String
    public var key: String?
    public var value: String?
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    private var enabled: Bool?

    public init(name: String, key: String? = nil, value: String? = nil) {
        self.name = name
        self.key = key
        self.value = value
    }

}

extension Parameter: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .fadeIn, .fadeOut, .keyframeAnimation, .parameters:
            return .element
        default:
            return .attribute
        }
    }

}

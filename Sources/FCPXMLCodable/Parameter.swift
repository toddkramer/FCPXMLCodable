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
    
    /// The fade in effect of the parameter.
    public var fadeIn: FadeIn?
    
    /// The fade out effect of the parameter.
    public var fadeOut: FadeOut?
    
    /// The keyframe animation of the parameter.
    public var keyframeAnimation: KeyframeAnimation?
    
    /// The child parameters of the parameter.
    public var parameters: [Parameter] = []
    
    /// The name of the parameter.
    public var name: String
    
    /// The key of the parameter.
    public var key: String?
    
    /// The value of the parameter.
    public var value: String?
    
    /// A Boolean value indicating whether the parameter is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    private var enabled: Bool?
    
    /// Initializes a new parameter.
    /// - Parameter name: The name of the parameter.
    /// - Parameter key: The key of the parameter.
    /// - Parameter value: The value of the parameter.
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

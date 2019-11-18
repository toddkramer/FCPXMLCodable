//
//  MatchProperty.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchProperty: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "enabled"
        case key, rule, value
    }
    
    /// Specifies the possible property keys to match in a property match.
    public enum Key: String, Codable {

        /// :nodoc:
        case reel

        /// :nodoc:
        case scene

        /// :nodoc:
        case take

        /// :nodoc:
        case audioOutputChannels

        /// :nodoc:
        case frameSize

        /// :nodoc:
        case videoFrameRate

        /// :nodoc:
        case audioSampleRate

        /// :nodoc:
        case cameraName

        /// :nodoc:
        case cameraAngle

    }
    
    /// A Boolean value indicating whether the property match is enabled.
    public var isEnabled: Bool = true
    
    /// The propery key to match.
    public var key: Key
    
    /// The rule to use for the property match.
    public var rule: Rule
    
    /// The property value to match.
    public var value: String
    
    /// Initializes a new property match.
    /// - Parameter key: The property key to match.
    /// - Parameter rule: The rule to use for the property match, `includes` by default.
    /// - Parameter value: The property value to match.
    public init(key: Key, rule: Rule = .includes, value: String) {
        self.key = key
        self.rule = rule
        self.value = value
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decodeIfPresent(Bool.self, forKey: .isEnabled) ?? true
        key = try container.decode(Key.self, forKey: .key)
        rule = try container.decodeIfPresent(Rule.self, forKey: .rule) ?? .includes
        value = try container.decode(String.self, forKey: .value)
    }

}

extension MatchProperty: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

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

    public enum Key: String, Codable {
        case reel, scene, take, audioOutputChannels, frameSize, videoFrameRate, audioSampleRate, cameraName, cameraAngle
    }

    public var isEnabled: Bool = true
    public var key: Key
    public var rule: Rule
    public var value: String

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

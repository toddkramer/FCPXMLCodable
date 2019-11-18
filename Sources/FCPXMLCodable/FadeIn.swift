//
//  FadeIn.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder
import CoreMedia

public struct FadeIn: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case type
        case duration
    }
    
    /// The type of the fade in effect.
    public var type: FadeType
    
    /// The duration of the fade in effect.
    public var duration: CMTime
    
    /// Initializes a new fade in effect.
    /// - Parameter type: The type of the fade in effect, `easeIn` by default.
    /// - Parameter duration: The duration of the fade in effect.
    public init(type: FadeType = .easeIn, duration: CMTime) {
        self.type = type
        self.duration = duration
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(FadeType.self, forKey: .type) ?? .easeIn
        duration = try container.decode(CMTime.self, forKey: .duration)
    }

}

extension FadeIn: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

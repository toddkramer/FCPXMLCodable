//
//  FadeOut.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder
import CoreMedia

public struct FadeOut: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case type
        case duration
    }

    public var type: FadeType
    public var duration: CMTime

    public init(type: FadeType = .easeOut, duration: CMTime) {
        self.type = type
        self.duration = duration
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(FadeType.self, forKey: .type) ?? .easeOut
        duration = try container.decode(CMTime.self, forKey: .duration)
    }

}

extension FadeOut: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

//
//  Mute.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Mute: XMLRepresentable {

    public var fadeIn: FadeIn?
    public var fadeOut: FadeOut?

    public var start: CMTime?
    public var duration: CMTime?

    public init(start: CMTime? = nil, duration: CMTime? = nil, fadeIn: FadeIn? = nil, fadeOut: FadeOut? = nil) {
        self.start = start
        self.duration = duration
        self.fadeIn = fadeIn
        self.fadeOut = fadeOut
    }

}

extension Mute: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .fadeIn, .fadeOut:
            return .element
        default:
            return .attribute
        }
    }

}

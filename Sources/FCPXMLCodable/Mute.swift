//
//  Mute.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Mute: XMLRepresentable {
    
    /// The fade in effect applied to the mute.
    public var fadeIn: FadeIn?
    
    /// The fade out effect applied to the mute.
    public var fadeOut: FadeOut?

    /// The start time of the mute.
    public var start: CMTime?
    
    /// The duration of the mute.
    public var duration: CMTime?
    
    /// Initializes a new mute.
    /// - Parameter start: The start time of the mute.
    /// - Parameter duration: The duration of the mute.
    /// - Parameter fadeIn: The fade in effect applied to the mute.
    /// - Parameter fadeOut: The fade out effect applied to the mute.
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

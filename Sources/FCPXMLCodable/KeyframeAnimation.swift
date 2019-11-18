//
//  KeyframeAnimation.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

public struct KeyframeAnimation: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case keyframes = "keyframe"
    }
    
    /// The keyframes of the keyframe animation.
    public var keyframes: [Keyframe]
    
    /// Initializes a new keyframe animation.
    /// - Parameter keyframes: The keyframes of the keyframe animation.
    public init(keyframes: [Keyframe]) {
        self.keyframes = keyframes
    }

}

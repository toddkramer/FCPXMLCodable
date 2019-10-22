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

    public var keyframes: [Keyframe]

    public init(keyframes: [Keyframe]) {
        self.keyframes = keyframes
    }

}

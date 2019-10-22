//
//  AudioLayout.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// The audio channel layout, one of `mono`, `stereo`, or `surround`. The default when this element is absent is `stereo`.
public enum AudioLayout: String, XMLRepresentable {

    /// :nodoc:
    case mono

    /// :nodoc:
    case stereo

    /// :nodoc:
    case surround

}

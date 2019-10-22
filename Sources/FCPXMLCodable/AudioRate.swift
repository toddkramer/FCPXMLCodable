//
//  AudioRate.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// The audio sample rate. The default value when this element is absent is `r48k`.
public enum AudioRate: String, XMLRepresentable {

    /// :nodoc:
    case r32k = "32k"

    /// :nodoc:
    case r44_1k = "44.1k"

    /// :nodoc:
    case r48k = "48k"

    /// :nodoc:
    case r88_2k = "88.2k"

    /// :nodoc:
    case r96k = "96k"

    /// :nodoc:
    case r176_4k = "176.4k"

    /// :nodoc:
    case r192k = "192k"

}

//
//  TimecodeFormat.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// The timecode display format, either drop frame (DF) or nondrop frame (NDF). The default when this element is absent is `nonDropFrame`.
public enum TimecodeFormat: String, XMLRepresentable {

    /// :nodoc:
    case dropFrame = "DF"

    /// :nodoc:
    case nonDropFrame = "NDF"

}

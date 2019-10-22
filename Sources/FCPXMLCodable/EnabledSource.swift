//
//  EnabledSource.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Defines the enabled source media type(s) for a clip.
public enum EnabledSource: String, XMLRepresentable {

    /// :nodoc:
    case all

    /// :nodoc:
    case audio

    /// :nodoc:
    case video

    /// :nodoc:
    case none

}

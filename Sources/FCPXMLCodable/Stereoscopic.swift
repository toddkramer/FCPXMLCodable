//
//  Stereoscopic.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Enumerates the supported stereoscopic modes in FCPX.
public enum Stereoscopic: String, XMLRepresentable {

    /// :nodoc:
    case mono

    /// :nodoc:
    case sideBySide = "side by side"

    /// :nodoc:
    case overUnder = "over under"

}

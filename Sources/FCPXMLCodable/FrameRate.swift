//
//  FrameRate.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Enumerates the possible sequence frame rates supported by FCPX.
public enum FrameRate: String, XMLRepresentable {

    /// :nodoc:
    case r23_98 = "23.98"

    /// :nodoc:
    case r24 = "24"

    /// :nodoc:
    case r25 = "25"

    /// :nodoc:
    case r29_97 = "29.97"

    /// :nodoc:
    case r30 = "30"

    /// :nodoc:
    case r60 = "60"

    /// :nodoc:
    case r47_95 = "47.95"

    /// :nodoc:
    case r48 = "48"

    /// :nodoc:
    case r50 = "50"

    /// :nodoc:
    case r59_94 = "59.94"

}

//
//  TimeMatchType.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Specifies the match criteria for `MatchTime` and `MatchTimeRange` in a `SmartCollection`.
public enum TimeMatchType: String, XMLRepresentable {

    /// :nodoc:
    case contentCreated

    /// :nodoc:
    case dateImported

}

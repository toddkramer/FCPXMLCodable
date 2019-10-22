//
//  Rule.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Enumerates the rules that can be applied when matching on various criteria in a `SmartCollection`.
public enum Rule: String, XMLRepresentable {

    /// :nodoc:
    case doesNotInclude

    /// :nodoc:
    case doesNotIncludeAll

    /// :nodoc:
    case doesNotIncludeAny

    /// :nodoc:
    case includes

    /// :nodoc:
    case includesAll

    /// :nodoc:
    case includesAny

    /// :nodoc:
    case isAfter

    /// :nodoc:
    case isBefore

    /// :nodoc:
    case isExactly = "is"

    /// :nodoc:
    case isInLast

    /// :nodoc:
    case isNotInLast

}

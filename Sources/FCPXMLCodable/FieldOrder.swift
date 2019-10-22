//
//  FieldOrder.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// The field order for interlaced (upper first or lower first), or progressive video (progressive).
public enum FieldOrder: String, XMLRepresentable {

    /// :nodoc:
    case lowerFirst = "lower first"

    /// :nodoc:
    case progressive

    /// :nodoc:
    case upperFirst = "upper first"

}

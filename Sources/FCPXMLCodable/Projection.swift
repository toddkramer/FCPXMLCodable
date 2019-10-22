//
//  Projection.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// The projection type, none for a traditional project or media, equirectangular or cubic for a 360 project or media.
public enum Projection: String, XMLRepresentable {

    /// :nodoc:
    case none

    /// :nodoc:
    case equirectangular

    /// :nodoc:
    case cubic

}

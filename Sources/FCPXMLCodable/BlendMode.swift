//
//  BlendMode.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Describes the blend mode of a `MaskShape` or `MaskIsolation`.
public enum BlendMode: String, XMLRepresentable {

    /// :nodoc:
    case add

    /// :nodoc:
    case subtract

    /// :nodoc:
    case multiply
}

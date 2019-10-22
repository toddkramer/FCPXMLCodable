//
//  FadeType.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Specifies the fade type for a `FadeIn` or `FadeOut` effect.
public enum FadeType: String, XMLRepresentable {

    /// :nodoc:
    case linear

    /// :nodoc:
    case easeIn

    /// :nodoc:
    case easeOut

    /// :nodoc:
    case easeInOut

}

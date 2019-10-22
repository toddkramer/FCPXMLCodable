//
//  ColorSpace.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Color space is described in terms of its three components: color primaries, transfer characteristics, and matrix coefficients.
/// For still images, the value can be sRGB IEC61966-2.1 or Adobe RGB (1998), in addition to those described in terms of components.
public enum ColorSpace: String, XMLRepresentable {

    /// :nodoc:
    case rec709 = "1-1-1 (Rec. 709)"

    /// :nodoc:
    case rec601NTSC = "6-1-6 (Rec. 601 (NTSC))"

    /// :nodoc:
    case rec601PAL = "5-1-6 (Rec. 601 (PAL))"

    /// :nodoc:
    case rec2020 = "9-1-9 (Rec. 2020)"

    /// :nodoc:
    case rec2020PQ = "9-16-9 (Rec. 2020 PQ)"

    /// :nodoc:
    case rec2020HLG = "9-18-9 (Rec. 2020 HLG)"

    /// :nodoc:
    case adobeRGB = "Adobe RGB (1998)"

    /// :nodoc:
    case sRGB = "sRGB IEC61966-2.1"

}

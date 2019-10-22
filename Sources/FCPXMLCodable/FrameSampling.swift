//
//  FrameSampling.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

/// Final Cut Pro X uses frame sampling to adjust playback speed for time maps and rate conforming. If both time maps and rate conforming are used on
/// the same clip, the frame sampling method must be the same.
public enum FrameSampling: String, XMLRepresentable {

    /// :nodoc:
    case floor

    /// :nodoc:
    case nearestNeighbor = "nearest-neighbor"

    /// :nodoc:
    case frameBlending = "frame-blending"

    /// :nodoc:
    case opticalFlowClassic = "optical-flow-classic"

    /// :nodoc:
    case opticalFlow = "optical-flow"

}

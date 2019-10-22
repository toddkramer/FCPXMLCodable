//
//  AnalysisMarker.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// An annotation that indicates the result of scene analysis to determine the number of people present and the shot and stabilization types.
public struct AnalysisMarker: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case shotTypes = "shot-type"
        case stabilizationTypes = "stabilization-type"
        case start, duration
    }

    /// The shot types contained in the scene.
    public var shotTypes: [ShotType] = []

    /// The stabilization types contained in the scene.
    public var stabilizationTypes: [StabilizationType] = []

    /// The start time of the marker.
    public var start: CMTime?

    /// The duration of the marker.
    public var duration: CMTime?

    /// Initializes a new analysis marker.
    /// - Parameter start: The start time of the analysis marker.
    /// - Parameter duration: The duration of the analysis marker.
    public init(start: CMTime? = nil, duration: CMTime? = nil) {
        self.start = start
        self.duration = duration
    }

}

extension AnalysisMarker: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .shotTypes, .stabilizationTypes:
            return .element
        default:
            return .attribute
        }
    }

}

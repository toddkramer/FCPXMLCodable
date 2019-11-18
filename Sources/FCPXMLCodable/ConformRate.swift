//
//  ConformRate.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Used to indicate rate conforming. When the timeline frame rate and the media frame rate are certain combinations, Final Cut Pro X automatically
/// applies rate conforming by converting the media frame rate to match the timeline frame rate. As a result, the duration is also adjusted.
/// - SeeAlso:
/// [FCPXML Story Elements](https://developer.apple.com/library/archive/documentation/FinalCutProX/Reference/FinalCutProXXMLFormat/StoryElements/StoryElements.html#//apple_ref/doc/uid/TP40011227-CH13-SW1)
public struct ConformRate: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isScaleEnabled = "scaleEnabled"
        case sourceFrameRate = "srcFrameRate"
        case frameSampling
    }

    /// A Boolean value that indicates whether scaling is enabled.
    public var isScaleEnabled: Bool = true
    
    /// The source frame rate of the rate conform.
    public var sourceFrameRate: FrameRate?
    
    /// The frame sampling method of the rate conform.
    public var frameSampling: FrameSampling
    
    /// Initializes a new conform rate.
    /// - Parameter sourceFrameRate: The source frame rate of the rate conform.
    /// - Parameter frameSampling: The frame sampling method of the rate conform.
    public init(sourceFrameRate: FrameRate? = nil, frameSampling: FrameSampling = .floor) {
        self.sourceFrameRate = sourceFrameRate
        self.frameSampling = frameSampling
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isScaleEnabled = try container.decodeIfPresent(Bool.self, forKey: .isScaleEnabled) ?? true
        sourceFrameRate = try container.decodeIfPresent(FrameRate.self, forKey: .sourceFrameRate)
        frameSampling = try container.decodeIfPresent(FrameSampling.self, forKey: .frameSampling) ?? .floor
    }

}

extension ConformRate: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

//
//  ConformRate.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct ConformRate: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case isScaleEnabled = "scaleEnabled"
        case sourceFrameRate = "srcFrameRate"
        case frameSampling
    }

    public var isScaleEnabled: Bool = true
    public var sourceFrameRate: FrameRate?
    public var frameSampling: FrameSampling

    public init(sourceFrameRate: FrameRate? = nil, frameSampling: FrameSampling = .floor) {
        self.sourceFrameRate = sourceFrameRate
        self.frameSampling = frameSampling
    }

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

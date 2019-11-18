//
//  Conform.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Modifies the image size of a clip to fill, fit, or remain unchanged within its container’s frame size. The type property specifies the conform
/// method to apply, which defaults to fit. With the absence of this adjustment, the clip is fit into the frame size.
/// - SeeAlso:
/// [FCPXML Adjustments And Effects](https://developer.apple.com/library/archive/documentation/FinalCutProX/Reference/FinalCutProXXMLFormat/Adjustments/Adjustments.html#//apple_ref/doc/uid/TP40011227-CH14-SW1)
public struct Conform: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    /// Specifies the possible types of a conform.
    public enum ConformType: String, Codable {

        /// :nodoc:
        case fit

        /// :nodoc:
        case fill

        /// :nodoc:
        case none

    }
    
    /// The type of the conform.
    public var type: ConformType? = .fit
    
    /// Initializes a new conform adjustment.
    /// - Parameter type: The type of the conform, `fit` by default.
    public init(type: ConformType = .fit) {
        self.type = type
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(ConformType.self, forKey: .type) ?? .fit
    }

}

extension Conform: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }

}

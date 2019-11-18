//
//  Equalization.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// Specifies the equalization applied to a clip.
public struct Equalization: XMLRepresentable {
    
    /// Specifies the possible modes of an equalization adjustment.
    public enum Mode: String, XMLRepresentable {

        /// :nodoc:
        case flat

        /// :nodoc:
        case voiceEnhance = "voice_enhance"

        /// :nodoc:
        case musicEnhance = "music_enhance"

        /// :nodoc:
        case loudness

        /// :nodoc:
        case humReduction = "hum_reduction"

        /// :nodoc:
        case bassBoost = "bass_boost"

        /// :nodoc:
        case bassReduce = "bass_reduce"

        /// :nodoc:
        case trebleBoost = "treble_boost"

        /// :nodoc:
        case trebleReduce = "treble_reduce"

    }
    
    /// The parameters associated with the equalization adjustment.
    public var parameters: [Parameter] = []
    
    /// The mode of the equalization adjustment.
    public var mode: Mode
    
    /// Initializes a new equalization adjustment.
    /// - Parameter mode: The mode of the equalization adjustment.
    public init(mode: Mode) {
        self.mode = mode
    }

}

extension Equalization: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .parameters:
            return .element
        default:
            return .attribute
        }
    }

}

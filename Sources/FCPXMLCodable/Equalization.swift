//
//  Equalization.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Equalization: XMLRepresentable {

    public enum Mode: String, XMLRepresentable {
        case flat
        case voiceEnhance = "voice_enhance"
        case musicEnhance = "music_enhance"
        case loudness
        case humReduction = "hum_reduction"
        case bassBoost = "bass_boost"
        case bassReduce = "bass_reduce"
        case trebleBoost = "treble_boost"
        case trebleReduce = "treble_reduce"
    }

    public var parameters: [Parameter] = []
    public var mode: Mode

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

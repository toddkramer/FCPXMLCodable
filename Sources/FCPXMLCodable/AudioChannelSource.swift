//
//  AudioChannelSource.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// Defines an audio component by its source channels.
public struct AudioChannelSource: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case loudness = "adjust-loudness"
        case noiseReduction = "adjust-noiseReduction"
        case humReduction = "adjust-humReduction"
        case equalization = "adjust-EQ"
        case matchEqualization = "adjust-matchEQ"
        case volume = "adjust-volume"
        case panner = "adjust-panner"
        case audioFilters = "filter-audio"
        case mutes = "mute"
        case sourceChannels = "srcCh"
        case outputChannels = "outCh"
        case role, start, duration, enabled, active
    }

    /// The loudness adjustment of the audio channel source.
    public var loudness: Loudness?

    /// The noise reduction adjustment of the audio channel source.
    public var noiseReduction: NoiseReduction?

    /// The hum reduction adjustment of the audio channel source.
    public var humReduction: HumReduction?

    /// The equalization adjustment of the audio channel source.
    public var equalization: Equalization?

    /// The match equalization adjustment of the audio channel source.
    public var matchEqualization: MatchEqualization?

    /// The volume adjustment of the audio channel source.
    public var volume: Volume?

    /// The panner adjustment of the audio channel source.
    public var panner: Panner?

    /// The audio filters applied to the audio channel source.
    public var audioFilters: [AudioFilter] = []

    /// The mutes applied to the audio channel source.
    public var mutes: [Mute] = []

    /// The audio source channels in the containing clip, such as "1, 2".
    /// Channels from underlying assets are sorted by their sourceID and then by their sourceChannels.
    public var sourceChannels: String

    /// An indication of how the audio source channels are assigned to the output, such as "L, R".
    public var outputChannels: String?

    /// The role of the audio channel source.
    public var role: String?

    /// The start time of the audio channel source.
    public var start: CMTime?

    /// The duration of the audio channel source.
    public var duration: CMTime?

    /// A Boolean value indicating whether the audio channel source is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    /// A Boolean value indicating whether the audio channel source is active.
    public var isActive: Bool {
        get { return active ?? true }
        set { active = newValue }
    }

    private var enabled: Bool?
    private var active: Bool?
    
    /// Initializes a new audio channel source with its audio source channels.
    /// - Parameter sourceChannels: The audio source channels in the containing clip, such as "1, 2".
    /// - Parameter role: The role of the audio channel source.
    public init(sourceChannels: String, role: String? = nil) {
        self.sourceChannels = sourceChannels
        self.role = role
    }

}

extension AudioChannelSource: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .sourceChannels, .outputChannels, .role, .start, .duration, .enabled, .active:
            return .attribute
        default:
            return .element
        }
    }

}

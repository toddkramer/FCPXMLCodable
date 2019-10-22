//
//  AudioRoleSource.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// Defines an audio component by its role.
public struct AudioRoleSource: XMLRepresentable {

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
        case role, start, duration, enabled, active
    }

    /// The loudness adjustment of the audio role source.
    public var loudness: Loudness?

    /// The noise reduction adjustment of the audio role source.
    public var noiseReduction: NoiseReduction?

    /// The hum reduction adjustment of the audio role source.
    public var humReduction: HumReduction?

    /// The equalization adjustment of the audio role source.
    public var equalization: Equalization?

    /// The match equalization adjustment of the audio role source.
    public var matchEqualization: MatchEqualization?

    /// The volume adjustment of the audio role source.
    public var volume: Volume?

    /// The panner adjustment of the audio role source.
    public var panner: Panner?

    /// The audio filters applied to the audio role source.
    public var audioFilters: [AudioFilter] = []

    /// The mutes applied to the audio role source.
    public var mutes: [Mute] = []

    /// The role of the associated audio component.
    public var role: String

    /// The start time of the audio role source.
    public var start: CMTime?

    /// The duration of the audio role source.
    public var duration: CMTime?

    /// A Boolean value indicating whether the audio role source is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }

    /// A Boolean value indicating whether the audio role source is active.
    public var isActive: Bool {
        get { return active ?? true }
        set { active = newValue }
    }

    private var enabled: Bool?
    private var active: Bool?
    
    /// Initializes a new audio role source with a role.
    /// - Parameter role: The role of the associated audio component.
    public init(role: String) {
        self.role = role
    }

}

extension AudioRoleSource: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .role, .start, .duration, .enabled, .active:
            return .attribute
        default:
            return .element
        }
    }

}

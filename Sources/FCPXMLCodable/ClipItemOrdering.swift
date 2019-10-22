//
//  ClipItemOrdering.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia

/// The offset of a clip specifies where it is located in its parent's timeline. Clips conforming to this protocol can be ordered according to that
/// timeline. See `ClipItemOrdering`.
public protocol Offsettable {

    var offset: CMTime? { get }

}

private enum ClipItemCodingKeys: String, CodingKey {
    case audio, video, clip, title
    case multicamClip = "mc-clip"
    case referenceClip = "ref-clip"
    case syncClip = "sync-clip"
    case assetClip = "asset-clip"
    case audition, gap, transition
}

/// The order of clips matters for `Spine` and `MulticamAngle` elements. This protocol defines how clip elements will be ordered when encoded.
public protocol ClipItemOrdering {

    /// :nodoc:
    var audios: [Audio] { get }

    /// :nodoc:
    var videos: [Video] { get }

    /// :nodoc:
    var clips: [Clip] { get }

    /// :nodoc:
    var titles: [Title] { get }

    /// :nodoc:
    var multicamClips: [MulticamClip] { get }

    /// :nodoc:
    var referenceClips: [ReferenceClip] { get }

    /// :nodoc:
    var syncClips: [SyncClip] { get }

    /// :nodoc:
    var assetClips: [AssetClip] { get }

    /// :nodoc:
    var auditions: [Audition] { get }

    /// :nodoc:
    var gaps: [Gap] { get }

    /// :nodoc:
    var transitions: [Transition] { get }

    /// The ordered clip items for encoding. The default implementation orders items by their `offset` property, which recreates how those clips
    /// were ordered in an FCPX timeline.
    var orderedClipItems: [Offsettable] { get }

}

extension ClipItemOrdering {

    public var orderedClipItems: [Offsettable] {
        var elements: [Offsettable] = []
        elements += audios
        elements += videos
        elements += clips
        elements += titles
        elements += multicamClips
        elements += referenceClips
        elements += syncClips
        elements += assetClips
        elements += auditions
        elements += gaps
        elements += transitions
        return elements.sorted {
            let offset1 = $0.offset ?? .zero
            let offset2 = $1.offset ?? .zero
            return offset1 < offset2
        }
    }

    func encodeOrderedClipItems(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ClipItemCodingKeys.self)
        for clipItem in orderedClipItems {
            switch clipItem {
            case let audio as Audio:
                try container.encode(audio, forKey: .audio)
            case let video as Video:
                try container.encode(video, forKey: .video)
            case let clip as Clip:
                try container.encode(clip, forKey: .clip)
            case let title as Title:
                try container.encode(title, forKey: .title)
            case let multicamClip as MulticamClip:
                try container.encode(multicamClip, forKey: .multicamClip)
            case let referenceClip as ReferenceClip:
                try container.encode(referenceClip, forKey: .referenceClip)
            case let syncClip as SyncClip:
                try container.encode(syncClip, forKey: .syncClip)
            case let assetClip as AssetClip:
                try container.encode(assetClip, forKey: .assetClip)
            case let audition as Audition:
                try container.encode(audition, forKey: .audition)
            case let gap as Gap:
                try container.encode(gap, forKey: .gap)
            case let transition as Transition:
                try container.encode(transition, forKey: .transition)
            default:
                break
            }
        }
    }

}

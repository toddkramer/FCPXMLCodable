//
//  MulticamSource.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MulticamSource: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case audioRoleSources = "audio-role-source"
        case crop = "adjust-crop"
        case corners = "adjust-corners"
        case conform = "adjust-conform"
        case transform = "adjust-transform"
        case blend = "adjust-blend"
        case stabilization = "adjust-stabilization"
        case rollingShutter = "adjust-rollingShutter"
        case transform360 = "adjust-360-transform"
        case reorient = "adjust-reorient"
        case orientation = "adjust-orientation"
        case videoFilters = "filter-video"
        case videoFilterMasks = "filter-video-mask"
        case angleID
        case _enabledSource = "srcEnable"
    }

    public var audioRoleSources: [AudioRoleSource] = []

    public var crop: Crop?
    public var corners: Corners?
    public var conform: Conform?
    public var transform: Transform?
    public var blend: Blend?
    public var stabilization: Stabilization?
    public var rollingShutter: RollingShutter?
    public var transform360: Transform360?
    public var reorient: Reorient?
    public var orientation: Orientation?

    public var videoFilters: [VideoFilter] = []
    public var videoFilterMasks: [VideoFilterMask] = []

    public var angleID: String
    public var enabledSource: EnabledSource {
        get { return _enabledSource ?? .all }
        set { _enabledSource = newValue }
    }

    private var _enabledSource: EnabledSource?

    public init(angleID: String) {
        self.angleID = angleID
    }

}

extension MulticamSource: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .angleID, ._enabledSource:
            return .attribute
        default:
            return .element
        }
    }

}

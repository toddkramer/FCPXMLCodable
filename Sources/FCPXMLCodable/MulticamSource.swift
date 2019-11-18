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
    
    /// The audio role sources of the multicam source.
    public var audioRoleSources: [AudioRoleSource] = []
    
    /// The crop adjustment applied to the multicam source.
    public var crop: Crop?
    
    /// The corners adjustment applied to the multicam source.
    public var corners: Corners?
    
    /// The conform adjustment applied to the multicam source.
    public var conform: Conform?
    
    /// The transform adjustment applied to the multicam source.
    public var transform: Transform?
    
    /// The blend adjustment applied to the multicam source.
    public var blend: Blend?
    
    /// The stabilization adjustment applied to the multicam source.
    public var stabilization: Stabilization?
    
    /// The rolling shutter adjustment applied to the multicam source.
    public var rollingShutter: RollingShutter?
    
    /// The 360 transform adjustment applied to the multicam source.
    public var transform360: Transform360?
    
    /// The reorient adjustment applied to the multicam source.
    public var reorient: Reorient?
    
    /// The orientation adjustment applied to the multicam source.
    public var orientation: Orientation?
    
    /// The video filters applied to the multicam source.
    public var videoFilters: [VideoFilter] = []
    
    /// The video filter masks applied to the multicam source.
    public var videoFilterMasks: [VideoFilterMask] = []
    
    /// The angle identifier of the multicam source.
    public var angleID: String
    
    /// Specifies which sources are enabled for the multicam source.
    public var enabledSource: EnabledSource {
        get { return _enabledSource ?? .all }
        set { _enabledSource = newValue }
    }

    private var _enabledSource: EnabledSource?
    
    /// Initializes a new multicam source.
    /// - Parameter angleID: The angle identifier of the multicam source.
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

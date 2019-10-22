//
//  Caption.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

public struct Caption: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case texts = "text"
        case textStyleDefinitions = "text-style-def"
        case note
        case lane, offset, name, start, duration, enabled
        case role
    }

    public var texts: [Text] = []
    public var textStyleDefinitions: [TextStyleDefinition] = []
    public var note: String?

    public var lane: Int?
    public var offset: CMTime?
    public var name: String?
    public var start: CMTime?
    public var duration: CMTime
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    public var role: String?

    private var enabled: Bool?

    public init(lane: Int? = nil, offset: CMTime = .zero, name: String? = nil, start: CMTime? = nil, duration: CMTime, role: String? = nil) {
        self.lane = lane
        self.offset = offset
        self.name = name
        self.start = start
        self.duration = duration
        self.role = role
    }

}

extension Caption: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .texts, .textStyleDefinitions, .note:
            return .element
        default:
            return .attribute
        }
    }

}

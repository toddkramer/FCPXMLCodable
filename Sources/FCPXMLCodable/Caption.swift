//
//  Caption.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia
import XMLCoder

/// A caption or subtitle with custom text elements.
public struct Caption: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case texts = "text"
        case textStyleDefinitions = "text-style-def"
        case note
        case lane, offset, name, start, duration, enabled
        case role
    }
    
    /// The texts of the caption.
    public var texts: [Text] = []
    
    /// The text style definitions of the caption.
    public var textStyleDefinitions: [TextStyleDefinition] = []
    
    /// A note associated with the caption.
    public var note: String?
    
    /// The lane of the caption.
    public var lane: Int?
    
    /// The offset of the caption.
    public var offset: CMTime?
    
    /// The name of the caption.
    public var name: String?
    
    /// The start time of the caption.
    public var start: CMTime?
    
    /// The duration of the caption.
    public var duration: CMTime
    
    /// A Boolean value that indicates whether the caption is enabled.
    public var isEnabled: Bool {
        get { return enabled ?? true }
        set { enabled = newValue }
    }
    
    /// Assigns a role to the underlying media component.
    /// The format is `role-name?captionFormat=captionFormat.subrole`.
    public var role: String?

    private var enabled: Bool?
    
    /// Initializes a new caption.
    /// - Parameter lane: The lane of the caption.
    /// - Parameter offset: The offset of the caption.
    /// - Parameter name: The name of the caption.
    /// - Parameter start: The start time of the caption.
    /// - Parameter duration: The duration of the caption.
    /// - Parameter role: The role of the caption.
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

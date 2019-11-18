//
//  Resources.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

protocol Resource: Identifiable, XMLRepresentable {}

/// A container for the resources contained in a FCPXML document.
public struct Resources: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case assets = "asset"
        case effects = "effect"
        case formats = "format"
        case medias = "media"
    }
    
    /// The assets included in a FCPXML document.
    public var assets: [Asset] = []
    
    /// The effects included in a FCPXML document.
    public var effects: [Effect] = []
    
    /// The formats included in a FCPXML document.
    public var formats: [Format] = []
    
    /// The media included in a FCPXML document.
    public var medias: [Media] = []
    
    /// Initializes a container of FCPXML resources.
    /// - Parameter assets: The assets to include in a FCPXML document.
    /// - Parameter effects: The effects to include in a FCPXML document.
    /// - Parameter formats: The formats to include in a FCPXML document.
    /// - Parameter medias: The medias to include in a FCPXML document.
    public init(assets: [Asset] = [], effects: [Effect] = [], formats: [Format] = [], medias: [Media] = []) {
        self.assets = assets
        self.effects = effects
        self.formats = formats
        self.medias = medias
    }

}

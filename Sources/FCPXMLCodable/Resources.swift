//
//  Resources.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation

protocol Resource: Identifiable, XMLRepresentable {}

public struct Resources: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case assets = "asset"
        case effects = "effect"
        case formats = "format"
        case medias = "media"
    }

    public var assets: [Asset] = []
    public var effects: [Effect] = []
    public var formats: [Format] = []
    public var medias: [Media] = []

    public init(assets: [Asset] = [], effects: [Effect] = [], formats: [Format] = [], medias: [Media] = []) {
        self.assets = assets
        self.effects = effects
        self.formats = formats
        self.medias = medias
    }

}

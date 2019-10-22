//
//  MatchEqualization.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchEqualization: XMLRepresentable {

    public var data: KeyedData

    public init(data: KeyedData) {
        self.data = data
    }

}

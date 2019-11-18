//
//  MatchEqualization.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct MatchEqualization: XMLRepresentable {
    
    /// The data of the match equalization adjustment.
    public var data: KeyedData
    
    /// Initializes a new match equalization adjustment.
    /// - Parameter data: The data of the match equalization adjustment.
    public init(data: KeyedData) {
        self.data = data
    }

}

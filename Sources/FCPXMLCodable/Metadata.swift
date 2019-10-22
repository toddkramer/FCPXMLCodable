//
//  Metadata.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

struct Metadata: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case metadata = "md"
    }

    var metadata: [Metadatum]

    init?(metadata: [Metadatum]?) {
        guard let metadata = metadata else { return nil }
        self.metadata = metadata
    }

}

//
//  CMTime+Codable.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import CoreMedia

extension CMTime: Codable {

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        let components = CMTime.timeComponents(from: string)
        self.init(value: components.value, timescale: components.timescale)
    }

    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(value)/\(timescale)s")
    }

    private static func timeComponents(from string: String) -> (value: CMTimeValue, timescale: CMTimeScale) {
        var string = string
        string = string.replacingOccurrences(of: "s", with: "")
        let components = string.components(separatedBy: "/")
        let value = CMTimeValue(components[0]) ?? 0
        let timescale = components.count == 1 ? 1 : CMTimeScale(components[1]) ?? 1
        return (value, timescale)
    }

}

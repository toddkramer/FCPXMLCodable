//
//  Volume.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Volume: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case amount
    }

    public var parameters: [Parameter] = []

    public var amount: Double

    public init(amount: Double) {
        self.amount = amount
    }

    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decibelString = try container.decodeIfPresent(String.self, forKey: .amount) ?? "0dB"
        let amountString = decibelString.replacingOccurrences(of: "dB", with: "")
        self.amount = Double(amountString) ?? 0
        parameters = try container.decode([Parameter].self, forKey: .parameters)
    }

    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("\(amount)dB", forKey: .amount)
        try container.encode(parameters, forKey: .parameters)
    }

}

extension Volume: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? CodingKeys else { return .element }
        switch key {
        case .parameters:
            return .element
        default:
            return .attribute
        }
    }

}

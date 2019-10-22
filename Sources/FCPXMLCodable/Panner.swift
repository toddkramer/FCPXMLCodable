//
//  Panner.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

public struct Panner: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case parameters = "param"
        case mode
        case _amount = "amount"
        case originalDecodedMix = "original_decoded_mix"
        case ambientDirectMix = "ambient_direct_mix"
        case surroundWidth = "surround_width"
        case leftRightMix = "left_right_mix"
        case frontBackMix = "front_back_mix"
        case lfeBalance = "LFE_balance"
        case rotation
        case stereoSpread = "stereo_spread"
        case attenuateCollapseMix = "attenuate_collapse_mix"
        case centerBalance = "center_balance"
    }

    public var parameters: [Parameter] = []

    public var mode: String?
    public var amount: Double {
        get { return _amount ?? 0 }
        set { _amount = newValue }
    }
    public var originalDecodedMix: Double?
    public var ambientDirectMix: Double?
    public var surroundWidth: Double?
    public var leftRightMix: Double?
    public var frontBackMix: Double?
    public var lfeBalance: Double?
    public var rotation: Double?
    public var stereoSpread: Double?
    public var attenuateCollapseMix: Double?
    public var centerBalance: Double?

    private var _amount: Double?

    public init(mode: String? = nil, amount: Double = 0) {
        self.mode = mode
        self._amount = amount
    }

}

extension Panner: DynamicNodeEncoding {

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

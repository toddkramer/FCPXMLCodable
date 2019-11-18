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
    
    /// The parameters associated with the panner adjustment.
    public var parameters: [Parameter] = []
    
    /// The mode of the panner adjustment.
    public var mode: String?
    
    /// The amount of the panner adjustment.
    public var amount: Double {
        get { return _amount ?? 0 }
        set { _amount = newValue }
    }
    
    /// The original decode mix of the panner adjustment.
    public var originalDecodedMix: Double?
    
    /// The ambient direct mix of the panner adjustment.
    public var ambientDirectMix: Double?
    
    /// The surround width of the panner adjustment.
    public var surroundWidth: Double?
    
    /// The left right mix of the panner adjustment.
    public var leftRightMix: Double?
    
    /// The front back mix of the panner adjustment.
    public var frontBackMix: Double?
    
    /// The LFE balance of the panner adjustment.
    public var lfeBalance: Double?
    
    /// The rotation of the panner adjustment.
    public var rotation: Double?
    
    /// The stereo spread of the panner adjustment.
    public var stereoSpread: Double?
    
    /// The attenuate collapse mix of the panner adjustment.
    public var attenuateCollapseMix: Double?
    
    /// The center balance of the panner adjustment.
    public var centerBalance: Double?

    private var _amount: Double?
    
    /// Initializes a new panner adjustment.
    /// - Parameter mode: The mode of the panner adjustment.
    /// - Parameter amount: The amount of the panner adjustment.
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

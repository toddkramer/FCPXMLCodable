//
//  ColorStringConversionTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XCTest
@testable import FCPXMLCodable

final class ColorStringConversionTests: XCTestCase {

    func testColorConversion() {
        let customColor = Color(red: 0.2, green: 0.3, blue: 0.4, alpha: 1.0)
        let black = Color(red: 0, green: 0, blue: 0, alpha: 1)
        let white = Color(red: 1, green: 1, blue: 1, alpha: 1)
        let testCases: [(color: Color, string: String)] =
            [(black, "0.0 0.0 0.0 1.0"), (white, "1.0 1.0 1.0 1.0"), (customColor, "0.2 0.3 0.4 1.0")]
        testCases.forEach {
            XCTAssertEqual($0.color.stringValue, $0.string)
            XCTAssertEqual($0.string.colorValue, $0.color)
        }
    }

}

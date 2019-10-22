//
//  CMTime+CodableTests.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)

import CoreMedia
import XMLCoder
import XCTest
@testable import FCPXMLCodable

final class CMTimeCodableTests: XCTestCase {

    struct Container: Codable, Equatable, DynamicNodeEncoding {
        let time: CMTime

        static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
            return .attribute
        }
    }

    func testCMTimeDecodingWithTimescale() {
        let xml = "<container time=\"1001/24000s\"/>"
        let data = xml.data(using: .utf8)!
        let container = try! XMLDecoder().decode(Container.self, from: data)
        let expected = CMTime(value: 1001, timescale: 24000)
        XCTAssertEqual(container.time, expected)
    }

    func testCMTimeEncodingWithTimescale() {
        let time = CMTime(value: 1001, timescale: 24000, flags: [], epoch: 0)
        let container = Container(time: time)
        let data = try! XMLEncoder().encode(container, withRootKey: "container")
        let encoded = String(data: data, encoding: .utf8)
        let expected = "<container time=\"1001/24000s\" />"
        XCTAssertEqual(encoded, expected)
    }

    func testCMTimeDecodingWithSeconds() {
        let xml = "<container time=\"5s\"/>"
        let data = xml.data(using: .utf8)!
        let container = try! XMLDecoder().decode(Container.self, from: data)
        let expected = CMTime(value: 5, timescale: 1)
        XCTAssertEqual(container.time, expected)
    }

    func testCMTimeDecodingWithInvalidEmptyString() {
        let xml = "<container time=\"\"/>"
        let data = xml.data(using: .utf8)!
        let container = try! XMLDecoder().decode(Container.self, from: data)
        let expected = CMTime(value: 0, timescale: 1)
        XCTAssertEqual(container.time, expected)
    }

    func testCMTimeDecodingWithInvalidString() {
        let xml = "<container time=\"A/Cs\"/>"
        let data = xml.data(using: .utf8)!
        let container = try! XMLDecoder().decode(Container.self, from: data)
        let expected = CMTime(value: 0, timescale: 1)
        XCTAssertEqual(container.time, expected)
    }

}

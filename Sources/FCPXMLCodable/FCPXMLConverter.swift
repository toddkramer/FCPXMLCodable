//
//  FCPXMLConverter.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import Foundation
import XMLCoder

/// An error thrown when FCPXML conversion fails.
public enum FCPXMLError: Error {

    /// An error thrown when the source FCPXML string is not valid.
    case invalidXMLString

}

public struct FCPXMLConverter {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter
    }()

    private static let xmlDecoder: XMLDecoder = {
        let decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()

    private static let xmlEncoder: XMLEncoder = {
        let encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()

    public static func fcpxmlDocument(from xmlString: String) throws -> FCPXMLDocument {
        guard let data = xmlString.data(using: .utf8) else { throw FCPXMLError.invalidXMLString }
        return try xmlDecoder.decode(FCPXMLDocument.self, from: data)
    }

    public static func xmlString(from fcpxmlDocument: FCPXMLDocument) throws -> String {
        let header = XMLHeader(version: 1.0, encoding: "UTF-8", standalone: "no")
        let data = try xmlEncoder.encode(fcpxmlDocument, withRootKey: "fcpxml", header: header)
        guard let xmlString = String(data: data, encoding: .utf8)?.convertXMLBooleanOutputToNumeric() else { throw FCPXMLError.invalidXMLString }
        return xmlString
    }

    public static func decode<T: Decodable>(_ type: T.Type, from xmlString: String) throws -> T {
        guard let data = xmlString.data(using: .utf8) else { throw FCPXMLError.invalidXMLString }
        return try xmlDecoder.decode(T.self, from: data)
    }

    public static func xmlString<T: Encodable>(from fcpxmlElement: T, rootKey: String) throws -> String {
        let data = try xmlEncoder.encode(fcpxmlElement, withRootKey: rootKey)
        guard let xmlString = String(data: data, encoding: .utf8)?.convertXMLBooleanOutputToNumeric() else { throw FCPXMLError.invalidXMLString }
        return xmlString
    }

    #if os(macOS)
    public static func xmlDocument(from fcpxmlDocument: FCPXMLDocument) throws -> XMLDocument {
        let xmlString = try self.xmlString(from: fcpxmlDocument)
        let document = try XMLDocument(xmlString: xmlString, options: [])
        let dtd = XMLDTD()
        dtd.name = "fcpxml"
        document.dtd = dtd
        return document
    }
    #endif

}

#if os(macOS)
extension XMLDocument {
    
    /// Validates an XMLDocument against the FCPXML version 1.8 DTD.
    ///
    /// This function temporarily replaces an empty DTD with the FCPXML DTD in order to call `validate()`. It then sets an empty DTD on the document
    /// again. This prevents the XML string from including the entire DTD. The FCPXML 1.8 DTD is also available as a public extension on `XMLDTD`
    /// and can be set on the document for cases when you would like to include the DTD in the ouput XML string.
    public func validateFCPXML() throws {
        let currentDTD = dtd
        dtd = .fcpxml
        try validate()
        dtd = currentDTD
    }

}
#endif

private extension String {

    func convertXMLBooleanOutputToNumeric() -> String {
        return replacingOccurrences(of: "=\"true\"", with: "=\"1\"").replacingOccurrences(of: "=\"false\"", with: "=\"0\"")
    }

}

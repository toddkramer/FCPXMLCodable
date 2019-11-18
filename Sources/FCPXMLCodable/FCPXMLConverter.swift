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
    
    /// Converts an XML string to a FCPXMLDocument value.
    /// - Parameter xmlString: The XML string to be converted.
    public static func fcpxmlDocument(from xmlString: String) throws -> FCPXMLDocument {
        guard let data = xmlString.data(using: .utf8) else { throw FCPXMLError.invalidXMLString }
        return try xmlDecoder.decode(FCPXMLDocument.self, from: data)
    }
    
    /// Converts a FCPXMLDocument value to a XML string.
    /// - Parameter fcpxmlDocument: The FCPXMLDocument to be converted.
    public static func xmlString(from fcpxmlDocument: FCPXMLDocument) throws -> String {
        let header = XMLHeader(version: 1.0, encoding: "UTF-8", standalone: "no")
        let data = try xmlEncoder.encode(fcpxmlDocument, withRootKey: "fcpxml", header: header)
        guard let xmlString = String(data: data, encoding: .utf8)?.convertXMLBooleanOutputToNumeric() else { throw FCPXMLError.invalidXMLString }
        return xmlString
    }
    
    /// A generic function for decoding a FCPXML element from a valid XML string.
    /// - Parameter type: The type that represents the XML element in Swift.
    /// - Parameter xmlString: The XML string to be decoded.
    public static func decode<T: Decodable>(_ type: T.Type, from xmlString: String) throws -> T {
        guard let data = xmlString.data(using: .utf8) else { throw FCPXMLError.invalidXMLString }
        return try xmlDecoder.decode(T.self, from: data)
    }
    
    /// A generic function that converts a FCPXML element from its Swift representation to a XML string.
    /// - Parameter fcpxmlElement: The FCPXML element to be converted.
    /// - Parameter rootKey: The XML root key to use for the FCPXML element.
    public static func xmlString<T: Encodable>(from fcpxmlElement: T, rootKey: String) throws -> String {
        let data = try xmlEncoder.encode(fcpxmlElement, withRootKey: rootKey)
        guard let xmlString = String(data: data, encoding: .utf8)?.convertXMLBooleanOutputToNumeric() else { throw FCPXMLError.invalidXMLString }
        return xmlString
    }

    #if os(macOS)
    /// Converts a FCPXMLDocument to a XMLDocument. The returned XMLDocument uses an empty DTD so that its string representation does not include
    /// the full FCPXML DTD. For validation use the `validateFCPXML` method included as an extension on XMLDocument.
    /// - Parameter fcpxmlDocument: <#fcpxmlDocument description#>
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

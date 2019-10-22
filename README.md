# FCPXMLCodable

![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/FCPXMLCodable/badge.png) [![Swift](https://img.shields.io/badge/swift-5.1-orange.svg?style=flat)](https://developer.apple.com/swift/) ![Platform](https://cocoapod-badges.herokuapp.com/p/FCPXMLCodable/badge.png)

## Overview

FCPXMLCodable is a Swift framework for working with FCPXML, providing type-safe conversion using Codable.

## Documentation

Available [here](https://www.tekramer.com/docs/FCPXMLCodable/index.html).

## Features

- Type-safe conversion of FCPXML documents to and from Swift
- Create JSON and Property List representations of FCPXML documents or individual elements
- Supports FCPXML 1.7 and later
- DTD Validation (macOS only)

## Usage

### Convert To Swift

```swift
do {
    let document = try FCPXMLConverter.fcpxmlDocument(from: xmlString)
    print(document)
} catch let error {
    print(error)
}
```

### Convert To XML String (all platforms)

```swift
do {
    let xmlString = try FCPXMLConverter.xmlString(from: document)
    print(xmlString)
} catch let error {
    print(error)
}
```

### Convert To XML Document And Validate (macOS only)

```swift
do {
    let xmlDocument = try FCPXMLConverter.xmlDocument(from: document)
    print(xmlDocument.xmlString)
    try xmlDocument.validateFCPXML()
} catch let error {
    print(error)
}
```

## Author

[Todd Kramer](https://www.tekramer.com)

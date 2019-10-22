//
//  FCPXMLDocument.swift
//
//  Copyright (c) 2019 Todd Kramer (https://www.tekramer.com)
//

import XMLCoder

/// An FCPXML document represents a Final Cut Pro X object. There are three supported object types, enumerated in `FCPXMLDocument.Configuration`.
@dynamicMemberLookup
public struct FCPXMLDocument: XMLRepresentable {

    private enum CodingKeys: String, CodingKey {
        case _importOptions = "import-options"
        case resources
        case version
        case library
        case events = "event"
        case clips = "clip"
        case auditions = "audition"
        case multicamClips = "mc-clip"
        case referenceClips = "ref-clip"
        case syncClips = "sync-clip"
        case assetClips = "asset-clip"
        case collectionFolders = "collection-folder"
        case keywordCollections = "keyword-collection"
        case smartCollections = "smart-collection"
        case projects = "project"
    }

    /// The DTD version of the document, "1.8" by default.
    public let version: String

    /// The import options to use for the document.
    public var importOptions: [ImportOption]? {
        get { return _importOptions?.importOptions }
        set { _importOptions = ImportOptions(importOptions: newValue) }
    }

    /// The resources referenced in the document.
    public var resources: Resources?

    /// The configuration of the document.
    public var configuration: Configuration {
        if let library = library {
            return .library(library)
        }
        if events.count > 0 {
            return .events(events)
        }
        var eventItems = EventItems()
        eventItems.clips = clips
        eventItems.auditions = auditions
        eventItems.multicamClips = multicamClips
        eventItems.referenceClips = referenceClips
        eventItems.syncClips = syncClips
        eventItems.assetClips = assetClips
        eventItems.collectionFolders = collectionFolders
        eventItems.keywordCollections = keywordCollections
        eventItems.smartCollections = smartCollections
        eventItems.projects = projects
        return .eventItems(eventItems)
    }

    private var library: Library?
    private var events: [Event] = []

    private var clips: [Clip] = []
    private var auditions: [Audition] = []
    private var multicamClips: [MulticamClip] = []
    private var referenceClips: [ReferenceClip] = []
    private var syncClips: [SyncClip] = []
    private var assetClips: [AssetClip] = []
    private var collectionFolders: [CollectionFolder] = []
    private var keywordCollections: [KeywordCollection] = []
    private var smartCollections: [SmartCollection] = []
    private var projects: [Project] = []

    private var _importOptions: ImportOptions?
    
    /// Initializes a new FCPXML document with its DTD version and configuration.
    /// - Parameter version: The DTD version of the document.
    /// - Parameter configuration: The configuration of the document.
    public init(version: String = "1.8", configuration: Configuration, resources: Resources? = nil) {
        self.version = version
        switch configuration {
        case .library(let library):
            self.library = library
        case .events(let events):
            self.events = events
        case .eventItems(let eventItems):
            self.clips = eventItems.clips
            self.auditions = eventItems.auditions
            self.multicamClips = eventItems.multicamClips
            self.referenceClips = eventItems.referenceClips
            self.syncClips = eventItems.syncClips
            self.assetClips = eventItems.assetClips
            self.collectionFolders = eventItems.collectionFolders
            self.keywordCollections = eventItems.keywordCollections
            self.smartCollections = eventItems.smartCollections
            self.projects = eventItems.projects
        }
        self.resources = resources
    }

    /// Enables dynamic member lookup of the document's resources, including assets, formats, effects, and media.
    public subscript<T>(dynamicMember keyPath: KeyPath<Resources, T>) -> T? {
        return resources?[keyPath: keyPath]
    }

}

// MARK: - Configuration

extension FCPXMLDocument {

    /// A FCPXML document can have one of three valid configurations: a library, a set of events, or a set of event items (including clips, projects,
    ///  keywords, and smart collections).
    public enum Configuration {

        /// :nodoc:
        case library(Library)

        /// :nodoc:
        case events([Event])

        /// :nodoc:
        case eventItems(EventItems)
    }

}

// MARK: - Import Options

extension FCPXMLDocument {

    
    /// Adds an import option specifying whether assets referenced in the imported XML should be copied or linked.
    /// - Parameter shouldCopyAssets: A Boolean value indicating whether assets should be copied (`true`) or linked (`false`).
    public mutating func setShouldCopyAssetsOnImport(_ shouldCopyAssets: Bool) {
        let value = shouldCopyAssets ? "1" : "0"
        var options = importOptions ?? []
        let copyAssetsOption = ImportOption(key: "copy assets", value: value)
        options.append(copyAssetsOption)
        importOptions = options
    }

    /// Adds an import option specifying whether or not warnings generated during import into FCPX should be suppressed.
    /// - Parameter shouldSuppressWarnings: A Boolean value indicating whether or not warnings should be suppressed.
    public mutating func setShouldSuppressWarningsOnImport(_ shouldSuppressWarnings: Bool) {
        let value = shouldSuppressWarnings ? "1" : "0"
        var options = importOptions ?? []
        let suppressWarningsOption = ImportOption(key: "suppress warnings", value: value)
        options.append(suppressWarningsOption)
        importOptions = options
    }
    
    /// Adds an import option specifying the location of the library into which events and projects should be imported.
    /// - Parameter location: The file URL of the library location. If the specified URL represents a directory, the default library name is used.
    /// If no library exists at the location specified, a new library is created.
    public mutating func setLibraryLocationForImport(_ location: String) {
        var options = importOptions ?? []
        let libraryLocationOption = ImportOption(key: "library location", value: location)
        options.append(libraryLocationOption)
        importOptions = options
    }

}

// MARK: - Dynamic Encoding

extension FCPXMLDocument: DynamicNodeEncoding {

    /// :nodoc:
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        guard let key = key as? FCPXMLDocument.CodingKeys else { return .element }
        switch key {
        case .version:
            return .attribute
        default:
            return .element
        }
    }
}

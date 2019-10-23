Pod::Spec.new do |s|
  s.name = 'FCPXMLCodable'
  s.version = '0.5.0'
  s.summary = 'Swift framework for working with FCPXML, providing type-safe conversion using Codable.'
  s.homepage = 'https://github.com/toddkramer/FCPXMLCodable'
  s.author = 'Todd Kramer'
  s.source = { :git => 'https://github.com/toddkramer/FCPXMLCodable.git', :tag => s.version }
  s.swift_versions = ['5.1']

  s.module_name = 'FCPXMLCodable'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Sources/FCPXMLCodable/*.swift'

  s.dependency 'XMLCoder', '0.8.0'
end


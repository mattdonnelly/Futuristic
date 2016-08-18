Pod::Spec.new do |s|
  s.name         = "Futuristic"
  s.version      = "1.0.0"
  s.description  = "A full featured Future implementation written in pure Swift"
  s.homepage     = "http://github.com/mattdonnelly/Futuristic"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Matt Donnelly"
  s.source       = { :git => "http://github.com/mattdonnelly/Futuristic.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"

  s.source_files  = "Source/*.swift"

  s.dependency 'Result', '~> 2.1'

  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '2.3' }
end

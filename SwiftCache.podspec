pod::Spec.new do |s|
  s.name = "SwiftCache"
  s.version = "0.1.0"
  s.license = "MIT"
  s.summary = "A data structure for Least Recently Used (LRU) image cache"
  s.homepage = "https://github.com/nixnoughtnothing/SwiftCache"
  s.social_media_url = "http://twitter.com/Ryoh778"
  s.authors = { "Ryoh Tsukahara" => "ryoh.t778@gmail.com" }
  s.source = { :git => "https://github.com/nixnoughtnothing/SwiftCache.git", :tag => s.version }
  s.ios.deployment_target = '7.0'
  s.source_files = "SwiftCache/*.swift"
  s.requires_arc = true
end

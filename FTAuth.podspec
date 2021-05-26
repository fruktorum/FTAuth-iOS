Pod::Spec.new do |spec|

  spec.name         = "FTAuth"
  spec.version      = "3.0.0"
  spec.summary      = "Module for authorization and registration"
  spec.homepage     = "https://github.com/fruktorum/FTAuth.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Fruktorum LLC" => "hi@fruktorum.com" }
  spec.platform     = :ios, "13.2"
  spec.ios.deployment_target = "13.2"
  spec.source       = { :git => "https://github.com/fruktorum/FTAuth.git", :tag => "#{spec.version}" }
  spec.source_files  = "FTAuthSources/**/*"

end

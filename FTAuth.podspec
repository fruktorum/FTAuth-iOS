Pod::Spec.new do |spec|

  spec.name         = "FTAuth"
  spec.version      = "3.0.10"
  spec.summary      = "Access to field validation methods is open"
  spec.homepage     = "https://github.com/fruktorum/FTAuth.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Fruktorum LLC" => "hi@fruktorum.com" }
  spec.platform     = :ios, "11.0"
  spec.ios.deployment_target = "11.0"
  spec.source       = { :git => "https://github.com/fruktorum/FTAuth.git", :tag => "#{spec.version}" }
  spec.source_files  = "FTAuthSources/**/*"

end

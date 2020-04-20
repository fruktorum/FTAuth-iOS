Pod::Spec.new do |spec|

  spec.name         = "FTAuth"
  spec.version      = "0.0.1"
  spec.summary      = "Module for authorization and registration"

  spec.homepage     = "https://github.com/GTimofey/FTAuth"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Gerasimov Timofey" => "gerasimovtv@rambler.ru" }

  spec.platform     = :ios, "13.2"

  spec.ios.deployment_target = "13.2"

  spec.source       = { :git => "https://github.com/GTimofey/FTAuth", :tag => "#{spec.version}" }


  spec.source_files  = "FTAuth/**/*"

end

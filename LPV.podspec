
Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '13.0'
s.name = "LPV"
s.summary = "LPV lets a user select view products with live video."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Chace Teera" => "hello@chaceteera.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/mteera/RWPod.git"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/mteera/RWPod.git",
             :tag => "0.1.0" }

# 7
s.framework = "UIKit"
s.framework = "Foundation"
s.dependency 'Alamofire', '~> 5.0.0-rc.3'
s.dependency 'Pulley'
s.dependency 'Kingfisher', '~> 5.0'

# 8
s.source_files = "LPV/**/*.{swift}"

# 9
s.resources = "LPV/**/*.{png,xcassets}"

# 10
s.swift_version = "5.0"

end

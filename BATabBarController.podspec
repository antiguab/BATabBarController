Pod::Spec.new do |s|
  s.name             = "BATabBarController"
  s.version          = "0.1.0"
  s.summary          = "A TabBarController with a unique animation for selection"
  s.description      = <<-DESC
                      The standard TabBarController is very limited in terms of animations when you make a selection.
                      This cocoapods allows you to use one with a sleek animation and other properties to customize!
                       DESC

  s.homepage         = "https://github.com/antiguab/BATabBarController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Bryan Antigua" => "antigua.b@gmail.com" }
  s.source           = { :git => "https://github.com/antiguab/BATabBarController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/brantigua'
  s.ios.deployment_target = '8.0'
  s.source_files = 'BATabBarController/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  
end

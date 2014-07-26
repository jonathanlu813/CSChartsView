Pod::Spec.new do |s|
  s.name         = "CSChartsView"
  s.version      = "0.2.0"
  s.summary      = "A light weight line graph drawing framework"
  s.description  = "This is a light weight line graph drawing framework,it is easy to use."
  s.homepage     = "https://github.com/jonathanlu813/CSChartsView"
  s.license      = { :type => "MIT" }
  s.authors             = { "Carl Shen" => "344208651@qq.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/jonathanlu813/CSChartsView.git", :tag => "0.2.0" }
  s.source_files  =  "Source/**/*.{h,m}"
  s.frameworks = "CoreGraphics", "UIKit" ,"Foundation"
  s.requires_arc = true
  s.screenshorts = ["https://raw.githubusercontent.com/sk344208651/CSChartsView/master/Image/IMG_0470.PNG","https://raw.githubusercontent.com/sk344208651/CSChartsView/master/Image/IMG_0473.PNG","https://raw.githubusercontent.com/sk344208651/CSChartsView/master/Image/IMG_0478.PNG","https://raw.githubusercontent.com/sk344208651/CSChartsView/master/Image/IMG_0479.PNG","https://raw.githubusercontent.com/sk344208651/CSChartsView/master/Image/IMG_0480.PNG"]
end

Pod::Spec.new do |s|
  s.name         = "KRGreyTheory"
  s.version      = "1.0.0"
  s.summary      = "Grey Theory on Machine Learning and Data Analysis."
  s.description  = <<-DESC
                   Machine Learning (マシンラーニング) in this project, it implemented the Grey Theory. This theory could use in big data analysis (データ分析), user behavior analysis (ユーザーの行動分析) and data mining (データマイニング) as well, especially find out what sub-factories impact on the real results via big data.
                   DESC
  s.homepage     = "https://github.com/Kalvar/ios-KRGreyTheory"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Kalvar Lin" => "ilovekalvar@gmail.com" }
  s.social_media_url = "https://twitter.com/ilovekalvar"
  s.source       = { :git => "https://github.com/Kalvar/ios-KRGreyTheory.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.public_header_files = 'ML/**/*.h'
  s.source_files = 'ML/**/*.{h,m}'
  s.frameworks   = 'Accelerate', 'Foundation'
end

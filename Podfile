platform :ios, '11.0'

target 'MyHeroes' do
  use_frameworks!

  ## separate module with API layer
  pod 'MyHeroesAPI', :git => 'https://github.com/gilson-gil/MyHeroesAPI.git'
  ##
  pod 'SwiftLint'

  target 'TodayHeroes' do
    inherit! :search_paths
  end

  target 'MyHeroesTests' do
    inherit! :search_paths

    pod 'Nimble'
    pod 'Quick'
  end
end

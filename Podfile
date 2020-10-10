# Uncomment the next line to define a global platform for your project
 platform :ios, '13.7'

target 'technicalexam' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # RxSwift & Extensions
  pod 'RxSwift'
  pod 'RxDataSources'
  pod 'RxRealm'
  pod 'RxOptional'
  pod 'RxKingfisher'
  
  # Offline Storage
  pod 'RealmSwift'
  
  # Utilites
  pod 'Swinject'
  pod 'SwiftLint'
  
  # Network
  pod 'Moya'
  pod 'ObjectMapper'
  pod 'Moya/RxSwift'
  
  # Depency Injection
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  
  # UI Libraries
  pod 'Kingfisher'
  pod 'SnapKit'
  pod 'Hero'

  target 'technicalexamTests' do
    inherit! :search_paths
      pod 'Quick'
      pod 'RxTest'
      pod 'Nimble'
      pod 'RxBlocking'
      pod 'RxNimble'
  end
  
  post_install do |installer|
       installer.pods_project.targets.each do |target|
           target.build_configurations.each do |config|
               config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
               config.build_settings['EXCLUDED_ARCHS[sdk=watchsimulator*]'] = 'arm64'
               config.build_settings['EXCLUDED_ARCHS[sdk=appletvsimulator*]'] = 'arm64'
      
           end
       end
   end
end

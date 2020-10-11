# Completed Tasks

1. Offline first Approach using Realm
2. Limits 5 page request api request with 10 items each
3. BDD Testing
4. Coding Conventions with SwiftLint
5. All views are created programatically 
6. Clean Architecture 
    - Dependecy Injection Using Swinject
    - Use case methodology
    - DTO, Entities and Domain
    - Delivery pattern using MVVM-C Architecture

# Note
 - If you are using xcode 12.0 or higher, and encountering error during app installation on simulator,please refer to this
https://realm.io/docs/swift/latest/#cocoapods

 - If you use < xcode 12.0 version remove this code from pod file
 
 ```Swift
   post_install do |installer|
       installer.pods_project.targets.each do |target|
           target.build_configurations.each do |config|
               config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
               config.build_settings['EXCLUDED_ARCHS[sdk=watchsimulator*]'] = 'arm64'
               config.build_settings['EXCLUDED_ARCHS[sdk=appletvsimulator*]'] = 'arm64'
      
           end
       end
   end
 ```

# Demo 
<img src="https://user-images.githubusercontent.com/5337290/95673729-f28df680-0bdd-11eb-8be5-b5139bb13c4a.gif" width="23%"></img> 

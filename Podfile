platform :ios, '11.4'

inhibit_all_warnings!
use_frameworks!

workspace 'SOExplorer'
project 'SOExplorer'

def core_pods
    pod 'Alamofire'
    pod 'Crashlytics'
    pod 'CocoaLumberjack/Swift'
    pod 'Fabric'
    pod 'ThunderCats'
    pod 'SwiftGen'
    pod 'Reusable'
end

target 'SOExplorer' do
    core_pods
  
  target 'SOExplorerTests' do
    inherit! :search_paths
  end
  
  target 'SOExplorerUITests' do
      inherit! :search_paths
  end
  
  target 'SOExplorerKIFTests' do
    inherit! :search_paths
    pod 'KIF', :configurations => ['Debug']
  end
end

platform :ios, '11.4'

inhibit_all_warnings!
use_frameworks!

workspace 'SOExplorer'
project 'SOExplorer'

def common_pods 
	pod 'OHHTTPStubs/Swift', :configurations => ['Debug']
end

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
    common_pods
  end
  
  target 'SOExplorerKIFTests' do
    inherit! :search_paths
    pod 'KIF', :configurations => ['Debug']
	common_pods
  end
end

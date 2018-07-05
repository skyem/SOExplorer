//
//  AppDelegate.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupCocoaLumberjack()
        return true
    }

    // MARK: - Utility
    
    func setupCocoaLumberjack() {
        
        guard let ttyLogger = DDTTYLogger.sharedInstance else { print("Unable to create CocoaLumberjack loggers"); return }
        
        DDLog.add(ttyLogger, with: .verbose)
    }
}


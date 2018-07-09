//
//  UIViewController+SOExplorer.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/8/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(for alert: Alert) {
        
        present(alert.alertController, animated: true, completion: nil)
    }
}

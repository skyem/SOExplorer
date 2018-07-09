//
//  BrowsingViewController.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/6/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit


class BrowsingViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

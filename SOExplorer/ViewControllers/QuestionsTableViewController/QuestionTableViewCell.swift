//
//  QuestionTableViewCell.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/6/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit
import Reusable

class QuestionTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var question: Question?
    
    // MARK: - Lifecycle
    
    // MARK: - Config
    
    func configure(withTitle title: String, isRead: Bool) {
        
        titleLabel.text = title
        roundedView.backgroundColor = isRead ? .usRed : .usBlue
        setUpRoundedView()
    }
    
    // MARK: - Setup
    
    func setUpRoundedView() {
        
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
}

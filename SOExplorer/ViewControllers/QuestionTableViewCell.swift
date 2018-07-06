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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(withTitle title: String) {
        
        titleLabel.text = title
    }
}

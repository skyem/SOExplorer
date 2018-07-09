//
//  Answer.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/8/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

struct Answer: SOCodable {
    
    let owner: Owner
    let isAccepted: Bool
    let creationDate: Date
    let answerId: Int
    let questionId: Int
}

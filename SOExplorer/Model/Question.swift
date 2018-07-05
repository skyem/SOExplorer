//
//  Question.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

struct Question: SOCodable {
    
    let acceptedAnswerId: Int?
    let answerCount: Int
    let creationDate: Date
    let isAnswered: Bool
    let link: URL?
    let owner: Owner
    let questionId: Int
    let tags: [String]
    let title: String
}

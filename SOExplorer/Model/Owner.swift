//
//  Owner.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

struct Owner: Codable {
    
    let displayName: String
    let link: URL?
    let profileImage: URL?
    let reputation: Int?
}

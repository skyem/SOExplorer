//
//  WebService+Questions.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

extension WebService {
    
    static func getQuestions(_ completion: @escaping WebServiceCompletion) {
        
        sendJSONRequest(.questions, method: .get, completion: completion)
    }
}

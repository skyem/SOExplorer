//
//  WebService+Questions.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

extension WebService {
    
    static func getQuestions(forPage page: Int, completion: @escaping WebServiceCompletion) {
        
        let parameters: JSON = [
            WebKeys.Core.page: page
        ]
        
        sendJSONRequest(.questions, method: .get, parameters: parameters, headers: nil, completion: completion)
    }
}

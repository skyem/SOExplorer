//
//  WebService+Answers.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/8/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

extension WebService {
    
    static func getAnswers(withIdentifiers identifiers: [Int], completion: @escaping WebServiceCompletion) {

        sendJSONRequest(.answers(identifiers: identifiers), method: .get, completion: completion)
    }
}

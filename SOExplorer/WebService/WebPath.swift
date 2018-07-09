//
//  WebPath.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import Alamofire

enum WebPath {
    
    case questions
    case answers(identifiers: [Int])
    
    var stringValue: String {
        
        switch self {
            
        case .questions:
            return WebKeys.Question.questions
            
        case .answers:
            return WebKeys.Answer.answers
        }
    }
    
    var path: String {

        switch self {
            
        case .answers(let identifiers):
            let identifierString = "/" + identifiers.map({ String($0) }).joined(separator: ";")
            return baseURL + stringValue + identifierString
            
        default:
            return baseURL + stringValue
        }
    }
    
    var baseURL: String {
        
        switch self {
            
        case .questions, .answers:
            return WebKeys.BaseURLs.stackExchange
        }
    }
}

extension WebPath: URLConvertible {
    
    func asURL() throws -> URL {
        
        return try path.asURL()
    }
}

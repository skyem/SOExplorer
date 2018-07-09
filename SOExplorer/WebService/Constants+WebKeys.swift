//
//  WebConstants.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

typealias WebKeys = Constants.Web

extension Constants {
    
    struct Web {
        
        struct BaseURLs {
            
            static let stackExchange = "https://api.stackexchange.com/"
        }
        
        struct Core {
            
            static let site = "site"
            static let stackOverflow = "stackoverflow"
            static let arrayDefault = "json_array_values"
            static let page = "page"
        }
        
        struct Question {
            
            static let items = "items"
            static let questions = "questions"
        }
        
        struct Answer {
            
            static let items = "items"
            static let answers = "answers"
        }
    }
}

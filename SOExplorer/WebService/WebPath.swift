//
//  WebPath.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import Alamofire

enum WebPath: String {
    
    case questions
    
    var path: String {

        return baseURL + self.rawValue
    }
    
    var baseURL: String {
        
        switch self {
            
        case .questions:
            return WebKeys.BaseURLs.stackExchange
        }
    }
}

extension WebPath: URLConvertible {
    
    func asURL() throws -> URL {
        
        return try path.asURL()
    }
}

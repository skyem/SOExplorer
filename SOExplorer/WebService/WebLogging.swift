//
//  WebLogging.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import Alamofire
import ThunderCats
import CocoaLumberjack

struct WebLogger {
    
    static func logRequest(using request: URLRequest?, response: DataResponse<Any>) {
        
        guard let urlRequest = request,
            let headers = urlRequest.allHTTPHeaderFields
        else { DDLogError("No request to log"); return }
        
        var logString = """
        _____________Log Start_____________
        
        URL: \(urlRequest.url?.absoluteString ?? "Unknown")
        
        Headers: \(NSDictionary(dictionary: headers).tc_JSONString() ?? "None")
        """
        
        switch response.result {
            
        case .success(let json):
            logString.append("\nResponse: \(json)")
            
        case .failure(let error):
            logString.append("\nError: \(error.localizedDescription)")
        }
        
        logString.append("\n_____________Log End_____________")
        
        print(logString)
    }
}

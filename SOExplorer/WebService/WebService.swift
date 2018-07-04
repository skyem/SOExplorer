//
//  WebService.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: Any]

class WebService {
    
    // MARK: - Type Aliases
    
    typealias WebServiceCompletion = (DataResponse<Any>) -> Void
    
    // MARK: - Properties
    
    static let sessionManager: SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        return SessionManager(configuration: configuration)
    }()
    
    // MARK: - Base Request Methods
    
    @discardableResult
    static func sendJSONRequest(_ path: WebPath, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping WebServiceCompletion) -> DataRequest {
    
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .head, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return sessionManager.request(path, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON(completionHandler: { response in
            
            WebLogger.logRequest(using: response.request, response: response)
            completion(response)
        })
    }
}

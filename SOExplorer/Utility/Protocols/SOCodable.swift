//
//  SODecodable.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import CocoaLumberjack

protocol SOCodable: Codable {
    
    static var decoder: JSONDecoder { get }
    static func decode(from jsonArray: [JSON]) -> [Self]
}

extension SOCodable {
    
    static var decoder: JSONDecoder {
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return jsonDecoder
    }
    
    static func decode(from jsonArray: [JSON]) -> [Self] {
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            return try Self.decoder.decode([Self].self, from: jsonData)
        }
        catch let error {
            DDLogError("Error parsing \(Self.self): \(error.localizedDescription)")
            return []
        }
    }
}

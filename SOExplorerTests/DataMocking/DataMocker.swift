//
//  DataMocker.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/5/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation

@testable import SOExplorer

class DataMocker {
    
    // MARK: - Utility
    
    static func loadJson(forFilename fileName: String) -> JSON? {
        
        if let url = Bundle(for: DataMocker.self).url(forResource: fileName, withExtension: "json") {
            if let data = NSData(contentsOf: url) {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? JSON
                    
                    return dictionary
                } catch {
                    print("Unable to parse  \(fileName).json")
                }
            }
            print("Unable to load  \(fileName).json")
        }
        
        return nil
    }
}

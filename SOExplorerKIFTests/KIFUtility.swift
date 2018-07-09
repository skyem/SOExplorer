//
//  KIFExtension.swift
//  SOExplorerKIFTests
//
//  Created by Skye McCaskey on 7/8/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import KIF

extension XCTestCase {
    
    // MARK: - Utility
    
    func tester(_ file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(_ file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func viewExists(withLabel label: String) -> Bool {
        
        do {
            try tester().tryFindingView(withAccessibilityLabel: label)
            return true
        }
        catch {
            return false
        }
    }
}

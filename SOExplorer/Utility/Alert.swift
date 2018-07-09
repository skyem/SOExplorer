//
//  Alert.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/8/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import ThunderCats

enum Alert {
    
    case errorRetrievingAnswers
    case errorRetrievingQuestions
    case invalidURL(actions: [UIAlertAction])
    case noProfile
    case unableToLoadAnswers
    
    var alert: (title: String, body: String) {
        
        switch self {
          
        case .errorRetrievingAnswers:
            return ("Error Retrieving Answers", "An error occured while retrieving the answers. Please try again later.")
            
        case .errorRetrievingQuestions:
            return ("Error Retrieving Questions", "An error occured while retrieving the questions. Please try again later.")
        
        case .invalidURL:
            return ("Invalid URL", "We are unable to load the contents of this view due to an invalid url.")
        case .noProfile:
            return ("No Profile", "No profile was found for this user.")
            
        case .unableToLoadAnswers:
            return ("Unable To Load", "We were unable to load the answers for this question. Please try again later.")
        }
    }
    
    var cancelTitle: String {
        
        switch self {
            
        default:
            return "Ok"
        }
    }
    
    var alertController: UIAlertController {
        
        let controller = UIAlertController.tc_alert(withTitle: alert.title, message: alert.body, cancelButtonTitle: cancelTitle, cancelAction: nil)
        
        switch self {
            
        case .invalidURL(let actions):
            actions.forEach { controller.addAction($0) }
            
        default:
            return controller
        }
        
        return controller
    }
}

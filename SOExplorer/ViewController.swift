//
//  ViewController.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit
import CocoaLumberjack
import ThunderCats

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebService.getQuestions { response in
            
            switch response.result {
                
            case .failure(let error):
                DDLogError("Unable to retrieve questions with error: \(error.localizedDescription)")
                let alert = UIAlertController.tc_alert(withTitle: "Error Retrieving Questions", message: "An error occured while retrieving the questions. Please try again later.", cancelButtonTitle: "Ok", cancelAction: nil)
                self.present(alert, animated: true, completion: nil)
                
            case .success(let json):
                DDLogDebug("Retrieved questions")
                guard let questionJSONArray = json[WebKeys.Question.items] as? [JSON] else { DDLogError("Questions array not found"); return }

                do {
                    let questions = try Question.decode(from: questionJSONArray)
                    DDLogVerbose("Questions: \(questions)")
                }
                catch let error {
    
                    DDLogError("Unable to decode Questions: \(error.localizedDescription)")
                }
            }
        }
    }
}


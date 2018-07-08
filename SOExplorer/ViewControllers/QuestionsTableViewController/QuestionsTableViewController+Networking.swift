//
//  QuestionsTableViewController+Networking.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/6/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import CocoaLumberjack

extension QuestionsTableTableViewController {
    
    func loadQuestions(forPage page: Int = 1) {
        
        WebService.getQuestions(forPage: page) { response in
            
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
                    let filteredQuestions = questions.filter { return $0.isAnswered && $0.answerCount > 1 }
                    self.questions.append(contentsOf: filteredQuestions)
                    DDLogDebug("Question count is: \(self.questions.count)")
                    if self.questions.count < self.preferredQuestionAmount && page < self.pageLimit {
                        
                        self.loadQuestions(forPage: page + 1)
                    }
                    else {
                        
                        self.tableView.reloadData()
                    }
                }
                catch let error {
                    
                    DDLogError("Unable to decode Questions: \(error.localizedDescription)")
                }
            }
        }
    }
}

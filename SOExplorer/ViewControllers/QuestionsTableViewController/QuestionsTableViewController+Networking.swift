//
//  QuestionsTableViewController+Networking.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/6/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import Foundation
import CocoaLumberjack
import NVActivityIndicatorView

extension QuestionsTableViewController {
    
    // MARK: - Networking
    
    func loadQuestions(forPage page: Int = 1) {
        
        showLoadingIndicator()
        
        WebService.getQuestions(forPage: page) { response in
            
            switch response.result {
                
            case .failure(let error):
                DDLogError("Unable to retrieve questions with error: \(error.localizedDescription)")
                self.hideLoadingIndicator()
                self.showAlert(for: .errorRetrievingQuestions)
                
            case .success(let json):
                DDLogDebug("Retrieved questions")
                guard let questionJSONArray = json[WebKeys.Question.items] as? [JSON]
                    else { DDLogError("Questions array not found"); self.hideLoadingIndicator(); return }
                
                do {
                    let questions = try Question.decode(from: questionJSONArray)
                    let filteredQuestions = questions.filter { return $0.acceptedAnswerId != nil && $0.answerCount > 1 }
                    self.questions.append(contentsOf: filteredQuestions)
                    DDLogDebug("Question count is: \(self.questions.count)")
                    if self.questions.count < self.preferredQuestionAmount && page < self.pageLimit {
                        
                        self.loadQuestions(forPage: page + 1)
                    }
                    else {
                        
                        self.loadAcceptedAnswers()
                    }
                }
                catch let error {
                    
                    DDLogError("Unable to decode Questions: \(error.localizedDescription)")
                    self.showAlert(for: .errorRetrievingQuestions)
                    self.hideLoadingIndicator()
                }
            }
        }
    }
    
    func loadAcceptedAnswers() {

        var acceptedAnswerQuestionDictionary: [Int: Question] = [:]
        
        for question in questions {
            
            guard let acceptedAnswerID = question.acceptedAnswerId else { continue }
            
            acceptedAnswerQuestionDictionary[acceptedAnswerID] = question
        }
        
        WebService.getAnswers(withIdentifiers: Array(acceptedAnswerQuestionDictionary.keys)) { response in
            
            defer { self.hideLoadingIndicator() }
            
            switch response.result {
                
            case .failure(let error):
                DDLogError("Unable to retrieve questions with error: \(error.localizedDescription)")
                self.showAlert(for: .errorRetrievingAnswers)
                
            case .success(let json):
                DDLogDebug("Retrieved answers")
                guard let answerJSONArray = json[WebKeys.Answer.items] as? [JSON] else { DDLogError("Answers array not found"); return }
                
                do {
                    let answers = try Answer.decode(from: answerJSONArray)
                    DDLogDebug("Answer count is: \(answers.count)")
                    
                    for answer in answers {
                        
                        acceptedAnswerQuestionDictionary[answer.answerId]?.acceptedAnswer = answer
                    }
                }
                catch let error {
                    
                    DDLogError("Unable to decode Answers: \(error.localizedDescription)")
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Utility
    
    fileprivate func showLoadingIndicator() {
        
        let activityData = ActivityData.init(message: "Loading Questions", type: .lineScalePulseOut)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    fileprivate func hideLoadingIndicator() {
        
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

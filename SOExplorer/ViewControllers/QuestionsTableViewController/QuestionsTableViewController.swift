//
//  QuestionsTableTableViewController.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/6/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit
import Reusable
import SafariServices
import CocoaLumberjack

class QuestionsTableViewController: UITableViewController {
    
    // MARK: - Constants
    
    let pageLimit = 5
    let preferredQuestionAmount = 80
    
    var acceptedAnswersToShow = Set<Int>()
    
    // MARK: - Properties
    
    var questions: [Question] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadQuestions()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(cellType: QuestionTableViewCell.self)
        setUpAccessibility()
    }
    
    // MARK: - Setup
    
    func setUpAccessibility() {
        
        tableView.accessibilityIdentifier = Constants.Accessibility.QuestionTableViewController.tableView
    }
    
    // MARK: - Utility
    
    private func showWebView(for url: URL, title: String) {
        
        let webViewController = WebViewController(url: url, title: title)
        show(webViewController, sender: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let question = questions[indexPath.row]
        let cell: QuestionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let acceptedAnswerID = question.acceptedAnswerId {
            
            cell.configure(using: question, shouldShowUserWithAcceptedAnswer: acceptedAnswersToShow.contains(acceptedAnswerID))
        }
        else {
            cell.configure(using: question, shouldShowUserWithAcceptedAnswer: false)
        }
       
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 336
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let question = questions[indexPath.row]
        question.isRead = true
        tableView.reloadData()
        
        guard let questionURL = question.link else { DDLogError("No url for question"); showAlert(for: .unableToLoadAnswers); return }
        
        showWebView(for: questionURL, title: "Question")
    }
}

extension QuestionsTableViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension QuestionsTableViewController: QuestionCellDelegate {
    
    func showUserWithAcceptedAnswer(withID identifier: Int, shouldShow: Bool) {
        
        if shouldShow {
            acceptedAnswersToShow.insert(identifier)
        }
        else {
            acceptedAnswersToShow.remove(identifier)
        }
        
        tableView.reloadData()
    }
    
    func showProfile(for owner: Owner) {
        
        guard let ownerURL = owner.link else { DDLogError("No url for owner"); showAlert(for: .noProfile); return }
        
        showWebView(for: ownerURL, title: "Profile")
    }
}

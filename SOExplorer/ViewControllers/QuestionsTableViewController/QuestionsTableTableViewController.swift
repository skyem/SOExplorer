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

class QuestionsTableTableViewController: UITableViewController {

    // MARK: - Constants
    
    let pageLimit = 1
    let preferredQuestionAmount = 30
    
    // MARK: - Properties
    
    var questions: [Question] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadQuestions()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(cellType: QuestionTableViewCell.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let question = questions[indexPath.row]
        let cell: QuestionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(withTitle: question.title, isRead: question.isRead ?? false)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let question = questions[indexPath.row]
        question.isRead = true
        tableView.reloadData()
        
        guard let questionURL = question.link else { return }
        
        let safariViewController = SFSafariViewController(url: questionURL.absoluteURL)
        safariViewController.delegate = self
        present(safariViewController, animated: true, completion: nil)
    }
}

extension QuestionsTableTableViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        dismiss(animated: true, completion: nil)
    }
}

//
//  QuestionsTableTableViewController.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/6/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit
import Reusable

class QuestionsTableTableViewController: UITableViewController {

    var questions: [Question] = []
    
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
    }
}

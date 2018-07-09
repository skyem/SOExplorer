//
//  QuestionTableViewCell.swift
//  SOExplorer
//
//  Created by Skye McCaskey on 7/6/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import UIKit
import Reusable
import AlamofireImage
import CocoaLumberjack

protocol QuestionCellDelegate: class {
    
    func showUserWithAcceptedAnswer(withID identifier: Int, shouldShow: Bool)
    func showProfile(for owner: Owner)
}

class QuestionTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewApprovedAnswerView: UIView!
    @IBOutlet weak var approvedAnswerStackView: UIStackView!
    @IBOutlet weak var showAnswerOwnerButton: UIButton!
    @IBOutlet weak var showAnswersLabel: UILabel!
    @IBOutlet weak var showWhoAnsweredLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var answeringUserImageView: UIImageView!
    @IBOutlet weak var answeringUserLabel: UILabel!
    @IBOutlet weak var answeringUserReputationLabel: UILabel!
    @IBOutlet weak var ownerButton: UIButton!
    @IBOutlet weak var answerOwnerButton: UIButton!
    
    weak var delegate: QuestionCellDelegate?
    var question: Question?
    var shouldShowAcceptedAnswer = false

    // MARK: - Config
    
    func configure(using question: Question, shouldShowUserWithAcceptedAnswer: Bool) {
        
        self.question = question
        self.shouldShowAcceptedAnswer = shouldShowUserWithAcceptedAnswer
        setUpAccessibility()
        setUpRoundedView()
        setUpQuestionViews(with: question)
        setUpApprovedAnswerView(with: question)
        setUpAnsweringUserViews(with: question)
    }
    
    // MARK: - Setup
    
    private func setUpAccessibility() {
        
        ownerButton.accessibilityLabel = Constants.Accessibility.QuestionTableViewCell.ownerProfile
        answerOwnerButton.accessibilityLabel = Constants.Accessibility.QuestionTableViewCell.answerOwnerProfile
    }
    
    func setUpRoundedView() {
        
        roundedView.layer.cornerRadius = 10
        roundedView.layer.masksToBounds = true
    }
    
    func setUpQuestionViews(with question: Question) {

        let isRead = question.isRead ?? false
        roundedView.backgroundColor = isRead ? UIColor.soBrown : .soTeal
        titleLabel.text = question.title
        questionNumberLabel.text = String(question.questionId)
        userNameLabel.text = question.owner.displayName
        tagsLabel.text = question.tags.joined(separator: " ")

        guard let userImageURL = question.owner.profileImage else { return }
        
        userImageView.af_setImage(withURL: userImageURL)
    }
    
    func setUpApprovedAnswerView(with question: Question) {
        
        showWhoAnsweredLabel.text = shouldShowAcceptedAnswer ? Constants.Questions.hideWhoAnsweredIt : Constants.Questions.showWhoAnsweredIt
        showAnswersLabel.text = "Show All \(question.answerCount) Answers"
        showAnswerOwnerButton.accessibilityLabel = shouldShowAcceptedAnswer ? Constants.Accessibility.QuestionTableViewCell.hideAnswersOwner : Constants.Accessibility.QuestionTableViewCell.showAnswersOwner
        viewApprovedAnswerView.isHidden = question.acceptedAnswerId == nil
        approvedAnswerStackView.isHidden = !shouldShowAcceptedAnswer
    }
    
    func setUpAnsweringUserViews(with question: Question) {
        
        guard let acceptedAnswer = question.acceptedAnswer, shouldShowAcceptedAnswer else { return }
        
        answeringUserLabel.text = acceptedAnswer.owner.displayName
        
        guard let userImageURL = acceptedAnswer.owner.profileImage else { return }
        
        answeringUserImageView.af_setImage(withURL: userImageURL)
        
        guard let reputation = acceptedAnswer.owner.reputation else {
            
            answeringUserReputationLabel.text = "Unknown"
            return
        }
        
        answeringUserReputationLabel.text = String(reputation)
    }
    
    // MARK: - Actions
    
    @IBAction func showAnswersOwnerWasTapped(_ sender: UIButton) {
        
        guard let acceptedAnswerID = question?.acceptedAnswerId else { assertionFailure("No acceptedAnswerID found in question"); return }
    
        delegate?.showUserWithAcceptedAnswer(withID: acceptedAnswerID, shouldShow: !shouldShowAcceptedAnswer)
    }
    
    @IBAction func ownerButtonWasTapped(_ sender: UIButton) {
        
        guard let question = question else { DDLogError("No question found"); return }
        
        delegate?.showProfile(for: question.owner)
    }
    
    @IBAction func answerOwnerButtonWasTapped(_ sender: UIButton) {
        
        guard let acceptedAnswer = question?.acceptedAnswer else { DDLogError("No question found"); return }
        
        delegate?.showProfile(for: acceptedAnswer.owner)
    }
}

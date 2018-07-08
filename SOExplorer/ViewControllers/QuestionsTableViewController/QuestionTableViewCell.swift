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
    
    func showAcceptedAnswer(withID identifier: Int, shouldShow: Bool)
    func showProfile(for owner: Owner)
}

class QuestionTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewApprovedAnswerView: UIView!
    @IBOutlet weak var approvedAnswerStackView: UIStackView!
    @IBOutlet weak var showAnswerOwnerButton: UIButton!
    @IBOutlet weak var viewAnswerLabel: UILabel!
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
    
    func configure(using question: Question, shouldShowAcceptedAnswer: Bool) {
        
        self.question = question
        self.shouldShowAcceptedAnswer = shouldShowAcceptedAnswer
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
        
        viewAnswerLabel.text = shouldShowAcceptedAnswer ? Constants.Questions.hideWhoAnsweredIt : Constants.Questions.showWhoAnsweredIt
        showAnswerOwnerButton.accessibilityLabel = shouldShowAcceptedAnswer ? Constants.Accessibility.QuestionTableViewCell.hideAnswersOwner : Constants.Accessibility.QuestionTableViewCell.showAnswersOwner
        viewApprovedAnswerView.isHidden = question.acceptedAnswerId == nil
        approvedAnswerStackView.isHidden = !shouldShowAcceptedAnswer
    }
    
    func setUpAnsweringUserViews(with question: Question) {
        
        guard shouldShowAcceptedAnswer else { return }
        
        answeringUserLabel.text = question.owner.displayName
        
        guard let userImageURL = question.owner.profileImage else { return }
        
        answeringUserImageView.af_setImage(withURL: userImageURL)
        
        guard let reputation = question.owner.reputation else {
            
            answeringUserReputationLabel.text = "Unknown"
            return
        }
        
        answeringUserReputationLabel.text = String(reputation)
    }
    
    // MARK: - Actions
    
    @IBAction func showAnswersOwnerWasTapped(_ sender: UIButton) {
        
        guard let acceptedAnswerID = question?.acceptedAnswerId else { assertionFailure("No acceptedAnswerID found in question"); return }
        
        delegate?.showAcceptedAnswer(withID: acceptedAnswerID, shouldShow: !shouldShowAcceptedAnswer)
    }
    
    @IBAction func ownerButtonWasTapped(_ sender: UIButton) {
        
        guard let question = question else { DDLogError("No question found"); return }
        
        delegate?.showProfile(for: question.owner)
    }
    
    @IBAction func answerOwnerButtonWasTapped(_ sender: UIButton) {
        
        guard let question = question else { DDLogError("No question found"); return }
        
        delegate?.showProfile(for: question.owner)
    }
}

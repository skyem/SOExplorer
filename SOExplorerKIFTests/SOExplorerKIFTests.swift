//
//  SOExplorerKIFTests.swift
//  SOExplorerKIFTests
//
//  Created by Skye McCaskey on 7/4/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import XCTest
import KIF

@testable import SOExplorer

class SOExplorerKIFTests: KIFTestCase {

    func testBrowser() {
        
        tester().waitForView(withAccessibilityLabel: "Stack Overflow Browser")
        tester().wait(forTimeInterval: 2)
        guard let _ = tester().waitForCell(at: IndexPath(row: 0, section: 0), inTableViewWithAccessibilityIdentifier: Constants.Accessibility.QuestionTableViewController.tableView, at: .top) as? QuestionTableViewCell else { XCTFail("No question cell found"); return }
        
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.ownerProfile)
        if viewExists(withLabel: Constants.Questions.showWhoAnsweredIt) {
            
            tester().tapView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.showAnswersOwner)
            tester().waitForView(withAccessibilityLabel: Constants.Questions.hideWhoAnsweredIt)
            tester().waitForView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.answerOwnerProfile)
            tester().tapView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.hideAnswersOwner)
            tester().waitForView(withAccessibilityLabel: Constants.Questions.showWhoAnsweredIt)
        }
    }
}

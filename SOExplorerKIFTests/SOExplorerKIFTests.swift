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
        
        // Test view appearance
        tester().waitForView(withAccessibilityLabel: "Stack Overflow Browser")
        tester().wait(forTimeInterval: 2)
        
        // Check for first cell
        let firstIndexPath = IndexPath(row: 0, section: 0)
        guard let _ = tester().waitForCell(at: firstIndexPath, inTableViewWithAccessibilityIdentifier: Constants.Accessibility.QuestionTableViewController.tableView, at: .top) as? QuestionTableViewCell else { XCTFail("No question cell found"); return }
        
        // Tap first cell to go to webview
        tester().tapRow(at: firstIndexPath, inTableViewWithAccessibilityIdentifier: Constants.Accessibility.QuestionTableViewController.tableView)
        tester().waitForView(withAccessibilityLabel: "Question")
        tester().tapView(withAccessibilityLabel: "Back")
        
        // Tap owner profile to go to webview
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.ownerProfile)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.ownerProfile)
        tester().waitForView(withAccessibilityLabel: "Profile")
        tester().tapView(withAccessibilityLabel: "Back")
        tester().waitForView(withAccessibilityLabel: "Stack Overflow Browser")
        
        // Show user who gave the accepted answer
        tester().waitForView(withAccessibilityLabel: Constants.Questions.showWhoAnsweredIt)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.showAnswersOwner)
        tester().waitForView(withAccessibilityLabel: Constants.Questions.hideWhoAnsweredIt)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.answerOwnerProfile)
        
        // Tap user to go to webview
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.answerOwnerProfile)
        tester().waitForView(withAccessibilityLabel: "Profile")
        tester().tapView(withAccessibilityLabel: "Back")
        
        // Hide user who gave the accepted answer
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.QuestionTableViewCell.hideAnswersOwner)
        tester().waitForView(withAccessibilityLabel: Constants.Questions.showWhoAnsweredIt)
    }
}

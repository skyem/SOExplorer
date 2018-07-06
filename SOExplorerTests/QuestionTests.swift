//
//  QuestionTests.swift
//  SOExplorerTests
//
//  Created by Skye McCaskey on 7/5/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import XCTest

@testable import SOExplorer

class QuestionTests: XCTestCase {

    let json = DataMocker.loadJson(forFilename: "questions_response")![WebKeys.Question.items] as! [JSON]
    var testQuestion: Question!
    var testQuestions: [Question]!
    
    override func setUp() {
        super.setUp()
        
        testQuestions = try! Question.decode(from: json)
        testQuestion = testQuestions.first!
    }
    
    func testQuestionsInitialization() {
        
        XCTAssertEqual(testQuestions.count, 30)
        XCTAssertNotNil(testQuestion)
        XCTAssertFalse(testQuestion.isAnswered)
        XCTAssertNil(testQuestion.acceptedAnswerId)
        XCTAssertEqual(testQuestion.answerCount, 0)
        XCTAssertEqual(testQuestion.creationDate, Date(timeIntervalSince1970: 1530719639))
        XCTAssertEqual(testQuestion.link?.absoluteString, "https://stackoverflow.com/questions/51177388/how-to-modify-an-array-of-objects-to-group-by-most-recent-year")
        XCTAssertEqual(testQuestion.questionId, 51177388)
        XCTAssertEqual(testQuestion.tags, ["javascript", "arrays", "ecmascript-6", "javascript-objects"])
        XCTAssertEqual(testQuestion.title, "How to modify an array of objects to group by most recent year?")
        
    }
    
    func testOwner() {
        
        XCTAssertNotNil(testQuestion.owner)
        XCTAssertEqual(testQuestion.owner.displayName, "Robert")
        XCTAssertEqual(testQuestion.owner.profileImage?.absoluteString, "https://www.gravatar.com/avatar/8ce8c00a894c374a59c10c9eaa09c462?s=128&d=identicon&r=PG")
        XCTAssertEqual(testQuestion.owner.link?.absoluteString, "https://stackoverflow.com/users/1257084/robert")
        XCTAssertEqual(testQuestion.owner.reputation, 313)
    }
}

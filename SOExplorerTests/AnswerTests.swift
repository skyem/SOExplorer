//
//  AnswerTests.swift
//  SOExplorerTests
//
//  Created by Skye McCaskey on 7/8/18.
//  Copyright © 2018 Skye McCaskey. All rights reserved.
//

import XCTest

@testable import SOExplorer

class AnswerTests: XCTestCase {

    let json = DataMocker.loadJson(forFilename: "answers_response")![WebKeys.Answer.items] as! [JSON]
    var testAnswer: Answer!
    var testAnswers: [Answer]!
    
    override func setUp() {
        super.setUp()
        
        testAnswers = AnswerTests.mockAnswers()
        testAnswer = testAnswers.first!
    }
    
    // MARK: - Utility
    
    static func mockAnswers() -> [Answer] {
        
        let json = DataMocker.loadJson(forFilename: "answers_response")![WebKeys.Answer.items] as! [JSON]
        return try! Answer.decode(from: json)
    }
    
    // MARK: - Tests

    func testAnswerModel() {
        
        XCTAssertEqual(testAnswers.count, 2)
        XCTAssertTrue(testAnswer.isAccepted)
        XCTAssertEqual(testAnswer.creationDate, Date(timeIntervalSince1970: 1531066320))
        XCTAssertEqual(testAnswer.answerId, 51233850)
        XCTAssertEqual(testAnswer.questionId, 51233812)
        XCTAssertNotNil(testAnswer.owner)
        XCTAssertEqual(testAnswer.owner.reputation, 2432)
        XCTAssertEqual(testAnswer.owner.displayName, "amrender singh")
        XCTAssertEqual(testAnswer.owner.profileImage?.absoluteString, "https://www.gravatar.com/avatar/4a7a1c907bbe5a869276a999ca9cda92?s=128&d=identicon&r=PG&f=1")
        XCTAssertEqual(testAnswer.owner.link?.absoluteString, "https://stackoverflow.com/users/6514231/amrender-singh")
    }
}

//
//  GameFlowTest.swift
//  QuizGameEngineTests
//
//  Created by Gary Maccabe on 20/02/2021.
//
//  Goal: To test the game routing system and flow

import Foundation
import XCTest
@testable import QuizGameEngine

class GameFlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSysUT(questions: []).start()

        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_1() {
        makeSysUT(questions: ["Question 1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSysUT(questions: ["Question 2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSysUT(questions: ["Question 1", "Question 2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sysut = makeSysUT(questions: ["Question 1", "Question 2"])
        sysut.start()
        sysut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Question 1", "Question 1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let sysut = makeSysUT(questions: ["Question 1", "Question 2"])
        sysut.start()
        router.answerCallback("Answer Question 1")
        
        XCTAssertEqual(router.routedQuestions, ["Question 1", "Question 2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToThirdQuestion() {
        let sysut = makeSysUT(questions: ["Question 1", "Question 2", "Question 3"])
        sysut.start()
        router.answerCallback("Answer Question 1")
        router.answerCallback("Answer Question 2")
        
        XCTAssertEqual(router.routedQuestions, ["Question 1", "Question 2", "Question 3"])
    }
    
    
    func makeSysUT(questions: [String]) -> GameFlow {
        return GameFlow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}

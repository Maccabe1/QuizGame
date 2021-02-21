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
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        //arange
        let router = RouterSpy()
        let sysut = GameFlow(questions: [], router: router)
        
        //act
        sysut.start()
        
        //assert
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_1() {
        let router = RouterSpy()
        let sysut = GameFlow(questions: ["Question 1"], router: router)
        
        sysut.start()
        XCTAssertEqual(router.routedQuestions, ["Question 1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let sysut = GameFlow(questions: ["Question 2"], router: router)
        
        sysut.start()
        XCTAssertEqual(router.routedQuestions, ["Question 2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let sysut = GameFlow(questions: ["Question 1", "Question 2"], router: router)
        
        sysut.start()
        XCTAssertEqual(router.routedQuestions, ["Question 1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let router = RouterSpy()
        let sysut = GameFlow(questions: ["Question 1", "Question 2"], router: router)
        
        sysut.start()
        sysut.start()
        XCTAssertEqual(router.routedQuestions, ["Question 1", "Question 1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let router = RouterSpy()
        let sysut = GameFlow(questions: ["Question 1", "Question 2"], router: router)
        
        sysut.start()
        router.answerCallback("Answer Question 1")
        
        XCTAssertEqual(router.routedQuestions, ["Question 1", "Question 2"])
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}

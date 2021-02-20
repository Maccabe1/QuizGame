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
    
    func test_start_with_no_questions_does_not_route_to_question(){
        //arange
        let router = RouterSpy()
        let sysut = GameFlow(questions: [], router: router)
        
        //act
        sysut.start()
        
        //assert
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_with_one_question_routes_to_question(){
        //arange
        let router = RouterSpy()
        let sysut = GameFlow(questions: ["Question 1"], router: router)
        
        //act
        sysut.start()
        
        //assert
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    class RouterSpy: Router {
        var routedQuestionCount = 0
        
        func routeTo(question: String) {
            routedQuestionCount += 1
        }
    }
}

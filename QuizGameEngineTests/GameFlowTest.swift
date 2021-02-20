//
//  GameFlowTest.swift
//  QuizGameEngineTests
//
//  Created by Gary Maccabe on 20/02/2021.
//
//  Goal: To test the routing system and game flow

import Foundation
import XCTest
@testable import QuizGameEngine

class GameFlowTest: XCTestCase {
    
    func test_start_with_no_questions(){
        //arange
        let router = RouterSpy()
        let sysut = GameFlow(router: router)
        
        //act
        sysut.start()
        
        //assert
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    class RouterSpy: Router {
        var routedQuestionCount = 0
    }
}

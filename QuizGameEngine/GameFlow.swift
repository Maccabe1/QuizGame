//
//  GameFlow.swift
//  QuizGameEngine
//
//  Created by Gary Maccabe on 20/02/2021.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class GameFlow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if(!questions.isEmpty) {
        router.routeTo(question: "")
        }
    }
}

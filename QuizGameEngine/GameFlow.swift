//
//  GameFlow.swift
//  QuizGameEngine
//
//  Created by Gary Maccabe on 20/02/2021.
//

import Foundation

protocol Router {}

class GameFlow {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        
    }
}

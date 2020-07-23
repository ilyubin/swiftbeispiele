//
//  Quiz.swift
//  MathQuiz
//
//  Created by Lyubin Igor on 22.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import Foundation

struct Quiz {
    let x: Int
    let y: Int
    let operation: Operation
    
    static func generate() -> Quiz {
        let o = Operation.allCases.randomElement()!
        let y = Int.random(in: (1...9))
        let x = generateX(y: y, operation: o)
        return Quiz(x: x, y: y, operation: o)
    }
    
    static private func generateX(y: Int, operation: Operation) -> Int {
        let x = Int.random(in: (1...9))
        if operation == Operation.division {
            return x * y
        }
        return x
    }
    
    func check(value: Int) -> Bool {
        switch operation {
        case .plus:
            return x + y == value
        case .minus:
            return x - y == value
        case .multiply:
            return x * y == value
        case .division:
            return x / y == value
        }
    }
}

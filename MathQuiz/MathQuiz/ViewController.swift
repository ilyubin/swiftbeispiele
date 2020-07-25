//
//  ViewController.swift
//  MathQuiz
//
//  Created by Lyubin Igor on 22.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var quiz: Quiz!
    var successCount: Int = 0
    var failCount: Int = 0
    
    private func generateQuiz() {
        quiz = Quiz.generate()
    }
    
    private func showQuiz() {
        quizLabel.text = "\(quiz.x) \(getOperationSymbol(operation: quiz.operation)) \(quiz.y) = ?"
    }
    
    fileprivate func showSuccess() {
        successCount += 1
        failCount = 0
        if successCount >= 10 {
            statusLabel.text = "🥰"
            return
        }
        statusLabel.text = String(repeating: "👍", count: successCount)
    }
    
    fileprivate func showFail() {
        successCount = 0
        failCount += 1
        if failCount >= 10 {
            statusLabel.text = "😡"
            return
        }
        statusLabel.text = String(repeating: "👎", count: failCount)
    }
    
    fileprivate func getOperationSymbol(operation: Operation) -> String {
        switch operation {
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "*"
        case .division:
            return "/"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, let value = Int(text) else {
            return false
        }
        textField.text = nil
        if !quiz.check(value: value) {
            showFail()
            return false
        }
        generateQuiz()
        showQuiz()
        showSuccess()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let set = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "-"))
        for u in string.unicodeScalars {
            if !set.contains(u) {
                return false
            }
        }
        return true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
        //textField.keyboardType = UIKeyboardType.numberPad
        statusLabel.text = nil
        generateQuiz()
        showQuiz()
    }
}

// Questions
// - как сделать клавиатуру только из цифр? Где тогда будет Enter?
// - как сделать обработку - если вводим слова буквами "hello"?
// - постоянно пишет Use of undeclared type 'Quiz' ?
// - может ли быть логика в модели? жирные контроллеры?
// - как создавать исключения/ошибки?

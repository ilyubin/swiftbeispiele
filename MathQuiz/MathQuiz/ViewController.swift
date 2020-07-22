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
    var model: QuizModel!
    
    private func generateQuiz() {
        let x = Int.random(in: (1...9))
        let y = Int.random(in: (1...9))
        model = QuizModel(x: x, y: y)
    }
    
    private func showQuiz() {
        quizLabel.text = "\(model.x) + \(model.y) = ?"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, let value = Int(text) else { return false }
        textField.text = nil
        if value == model.x + model.y {
            statusLabel.text = "👍"
            generateQuiz()
            showQuiz()
        } else {
            statusLabel.text = "👎"
        }
        return false
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
        statusLabel.text = nil
        generateQuiz()
        showQuiz()
    }
}

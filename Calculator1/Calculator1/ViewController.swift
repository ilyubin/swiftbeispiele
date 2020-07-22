//
//  ViewController.swift
//  Calculator1
//
//  Created by Lyubin Igor on 19.07.2020.
//  Copyright © 2020 AP Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberFromScreen: Double = 0
    var firstNum: Double = 0
    var mathSign: Bool = false
    var operation: Int = 0

    @IBOutlet weak var result: UILabel!

    @IBAction func digits(_ sender: UIButton) {
        var value = result.text! + String(sender.tag)
        if mathSign {
            value = String(sender.tag)
            mathSign = false
        }
        result.text = value
        numberFromScreen = Double(result.text!)!
    }

    @IBAction func buttons(_ sender: UIButton) {
        mathSign = true
        if result.text == "" {
            return
        }
        if sender.tag == 10 { // clear
            result.text = ""
            numberFromScreen = 0
            firstNum = 0
            operation = 0
            return
        }
        if sender.tag == 15 { // equal
            var v: Double = 0
            if operation == 11 { // cut
                v = firstNum / numberFromScreen
            }
            if operation == 12 { // multiply
                v = firstNum * numberFromScreen
            }
            if operation == 13 { // minus
                v = firstNum - numberFromScreen
            }
            if operation == 14 { // plus
                v = firstNum + numberFromScreen
            }
            result.text = (v.truncatingRemainder(dividingBy: 1) == 0) ? String(Int(v)) : String(v)
            return
        }
        firstNum = Double(result.text!)!
        if sender.tag == 11 { // cut
            result.text = "/"
        }
        if sender.tag == 12 { // multiply
            result.text = "x"
        }
        if sender.tag == 13 { // minus
            result.text = "-"
        }
        if sender.tag == 14 { // plus
            result.text = "+"
        }
        operation = sender.tag
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

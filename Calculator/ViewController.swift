//
//  ViewController.swift
//  Calculator
//
//  Created by Sheryl Shi on 4/3/17.
//  Copyright © 2017 Sheryl Shi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstNumberText = ""
    var secondNumberText = ""
    var currentText = ""
    var op = ""
    var isFirstNumber = true
    var isFirstDigitInFirstNumber = true
    var isFirstDigitInSecondNumber = false
    var hasOp = false
    var canClear = true
    var hasDecimal = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Function to handle all buttons in UI
    @IBAction func handleButtonPress(sender: UIButton) {
        if canClear {
            resultLabel.text = currentText
            canClear = false
        }
        currentText = resultLabel.text!
        let textLabel = sender.titleLabel?.text
        if let text = textLabel {
            switch text {
            // operator
            case "+", "×", "÷", "−":
                if hasOp {
                    return
                }
                op = text
                isFirstNumber = false
                isFirstDigitInSecondNumber = true
                hasOp = true
                canClear = true
                hasDecimal = false
                resultLabel.text = currentText + text
                currentText = "0"
                break
            // calculate final result
            case "=":
                if !firstNumberText.isEmpty && !secondNumberText.isEmpty {
                    isFirstNumber = true
                    isFirstDigitInFirstNumber = true
                    isFirstDigitInSecondNumber = false
                    hasOp = false
                    canClear = true
                    let result = calculate()
                    var resultText = "\(result)"
                    if floor(result) == result {
                        resultText = "\(Int(result))"
                    }
                    firstNumberText = resultText
                    currentText = firstNumberText
                    resultLabel.text = resultText
                }
                break
            // negative the current value
            case "+/−":
                var num = Double(currentText)!
                if num != 0 {
                    num = -num
                    if isFirstNumber {
                        firstNumberText = "\(num)"
                    } else {
                        secondNumberText = "\(num)"
                    }
                    resultLabel.text = "\(num)"
                }
                break
            // clear current value
            case "C":
                if isFirstNumber {
                    firstNumberText = ""
                } else {
                    secondNumberText = ""
                }
                currentText = ""
                canClear = true
                hasDecimal = false
                resultLabel.text = "0"
                break
            // add decmical
            case ".":
                if !hasDecimal {
                    hasDecimal = true
                    if isFirstNumber && floor(Double(firstNumberText)!) == Double(firstNumberText)! {
                        firstNumberText = "\(Int(firstNumberText))" + text
                    } else {
                        secondNumberText = secondNumberText + text
                    }
                    resultLabel.text = currentText + text
                }
                break
            // calculate % of current value
            case "%":
                if !isFirstDigitInFirstNumber || !isFirstDigitInSecondNumber {
                    var num = Double(currentText)!
                    num = num/100
                    currentText = "\(num)"
                    if isFirstNumber {
                        firstNumberText = currentText
                    } else {
                        secondNumberText = currentText
                    }
                    resultLabel.text = currentText
                }
                break
            // add digits to the end current value
            default:
                if isFirstNumber {
                    if isFirstDigitInFirstNumber {
                        currentText = ""
                        isFirstDigitInFirstNumber = false
                        firstNumberText = ""
                    }
                    firstNumberText = firstNumberText + text
                } else {
                    if isFirstDigitInSecondNumber {
                        currentText = ""
                        isFirstDigitInSecondNumber = false
                        secondNumberText = ""
                    }
                    secondNumberText = secondNumberText + text
                }
                resultLabel.text = currentText + text
                break;
            }
        }

    }
    
    // do calculation
    func calculate() -> Double {
        let firstNumber = Double(firstNumberText)!
        let secondNumber = Double(secondNumberText)!
        switch op {
        case "+":
            return firstNumber + secondNumber
        case "−":
            return firstNumber - secondNumber
        case "×":
            return firstNumber * secondNumber
        case "÷":
            return firstNumber / secondNumber
        default:
            return 0
        }
    }


}


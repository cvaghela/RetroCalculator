//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Chintan Vaghela on 2/3/17.
//  Copyright © 2017 CVBuilts. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!

    @IBOutlet weak var lblOutput: UILabel!
    
    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
        case Clear = "Clear"

    }
    
    var runningNumber = ""
    
    var currentOperation = Operation.Empty
    
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed (sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        lblOutput.text = runningNumber
    }
    
    @IBAction func onDividePressed (sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed (sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed (sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed (sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed (sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed (sender: AnyObject) {
        processOperation(operation: .Empty)
        leftValString = ""
        rightValString = ""
        result = ""
        runningNumber = ""
        lblOutput.text = "0"
    }
    
    func playSound() {
        
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    func processOperation (operation: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Divide {
                    
                     result = "\(Double(leftValString)! / Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    
                     result = "\(Double(leftValString)! - Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Add {
                    
                     result = "\(Double(leftValString)! + Double(rightValString)!)"
                    
                }
                
                leftValString = result
                lblOutput.text = result
                
            }
            
            currentOperation = operation
        } else {
            //This the first time that operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
}


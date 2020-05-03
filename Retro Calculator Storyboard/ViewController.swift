//
//  ViewController.swift
//  Retro Calculator Storyboard
//
//  Created by Muhammad Anjum Kaiser on 30/04/2020.
//  Copyright © 2020 Muhammad Anjum Kaiser. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    var currentOperation = Operation.Empty
    var leftValString = ""
    var rightValString = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(" Error playing \(err.debugDescription)")
        }
    }
    
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    func processOperation(operation: Operation) {
        playSound()
        
        if Operation.Empty != currentOperation {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if Operation.Multiply == currentOperation {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if Operation.Divide == currentOperation {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if Operation.Subtract == currentOperation {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if Operation.Add == currentOperation {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                leftValString = result
                outputLabel.text = result
            }
            
            currentOperation = operation
            
        } else {
            
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
    }
    
}


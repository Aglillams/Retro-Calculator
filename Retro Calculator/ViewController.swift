//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Nivelate Online on 5/26/16.
//  Copyright © 2016 Agliberto Llamas. All rights reserved.
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
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftVarNum = ""
    var rightVarNum = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            
        try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
        
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func clear(sender: AnyObject) {
        clear()
    }
    
    
    func processOperation (op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightVarNum = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftVarNum)! * Double(rightVarNum)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVarNum)! / Double(rightVarNum)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftVarNum)! + Double(rightVarNum)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVarNum)! - Double(rightVarNum)!)"
                }
                
                leftVarNum = result
                outputLbl.text = result
                
            }
            
            
            currentOperation = op
            
        }else{
            leftVarNum = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
   
    func playSound () {
        if btnSound.playing{
            
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func clear () {
        playSound()
        
        runningNumber = ""
        leftVarNum = ""
        rightVarNum = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
        
        
    }
    
}


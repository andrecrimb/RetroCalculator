//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Andre Rosa on 29/01/17.
//  Copyright © 2017 Andre Rosa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber    = ""
    var currentOperation = Operation.Empty
    var leftValStr       = ""
    var rightValStr      = ""
    var result           = ""
    
    enum Operation : String {
        case Divide    = "/"
        case Multiply  = "*"
        case Subtract = "-"
        case Add       = "+"
        case Empty     = "Empty"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)

        do{
            
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLabel.text = "0"
        
    }
 
    @IBAction func numberPress(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePress(sender : AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPress(sender : AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPress(sender : AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPress(sender : AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPress(sender : AnyObject){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        btnSound.play()
    }
    
    func processOperation(operation : Operation){
        playSound()
        if currentOperation != Operation.Empty{
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                leftValStr = result
                outputLabel.text = result
            }
            currentOperation = operation
        }
        else{
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}


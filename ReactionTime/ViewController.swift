//
//  ViewController.swift
//  ReactionTime
//
//  Created by Robert D. Brown on 7/26/17.
//  Copyright © 2017 Robert D. Brown. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var buttonCollection: [UIButton]!
    
    var passedArrayOf: ArrayOf!
    var timeCounter = 0.0
    var timer = Timer()
    var buttonTimer = Timer()
    var tapCounter = 0
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(timeCounter)
        
        turnButtonsBlue()
        hideAllButtons()
        
        buttonCollection.first?.alpha = 1.0
    }
    
    
    func turnButtonsBlue()
    {
        for button in buttonCollection
        {
            button.backgroundColor = .blue
        }
    }
    
    func hideAllButtons()
    {
        for button in buttonCollection
        {
            button.alpha = 0.0
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        passedArrayOf.scores.append(timeCounter)
        passedArrayOf.names.append(name)
        updateCloud()
    }
    
    func updateCloud() {
        //Code here to write data to firebase
    }
    
    @IBAction func buttonWasClicked(_ sender: UIButton) {
        
        if tapCounter == 0 {
            startTimer()
        }
        
        tapCounter += 1
        
        if tapCounter == 10 {
            stopTimer()
            buttonTimer.invalidate()
            for button in buttonCollection
            {
                button.backgroundColor = .red
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (time) in
            self.timeCounter += 0.01
            self.timeLabel.text = String(self.timeCounter)
        })
        
        
        buttonTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(slider.value), repeats: true) { (timer) in
                let randomNumber = Int.random(in: 0..<self.buttonCollection.count)
                self.hideAllButtons()
                self.buttonCollection[Int(randomNumber)].alpha = 1.0
        }
        
    }
    
    func stopTimer() {
        timer.invalidate()
    }
}


//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var finishedChange: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var alarmSound : AVAudioPlayer?
    
    
    var countdownTimer: Timer!
    var timeLeft : Int!
    var totalTime : Int!

    
    let nameTime = ["Soft": 3, "Medium":5, "Hard":7]

    @IBAction func selectedHardness(_ sender: UIButton) {
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        //progress starts as 0
        progressBar.progress=0.0
        let selectedTitle = sender.currentTitle
        finishedChange.text=selectedTitle
        
        if(selectedTitle != nil){
            let selectedTime = nameTime[selectedTitle!]
            timeLeft = (selectedTime!)
            totalTime = timeLeft
        }
    }
    
    @objc func updateTime(){
        //print(timeLeft)
        
        var timePassed = totalTime-timeLeft
        
        print(timePassed)
        
        progressBar.progress=Float(timePassed)/Float(totalTime)
        
        if(timeLeft != 0){
            timeLeft-=1
        } else{
            endTimer()
        }
    }
    
    func endTimer(){
        finishedChange.text="DONE!"
        
        let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType:nil)!
        
        let url = URL(fileURLWithPath: path)
        
        do {
            alarmSound = try AVAudioPlayer(contentsOf: url)
            alarmSound?.play()
        } catch {
            // couldn't load file :(
        }
        
        countdownTimer.invalidate()
    }
    
}

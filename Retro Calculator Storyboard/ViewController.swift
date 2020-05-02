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
    
    
    var btnSound: AVAudioPlayer!

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
    }
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
}


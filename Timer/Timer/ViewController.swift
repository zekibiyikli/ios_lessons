//
//  ViewController.swift
//  Timer
//
//  Created by Mono on 26.03.2026.
//

import UIKit

class ViewController: UIViewController {

    var counter=10
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerFunction(){
        counter-=1
        print(counter)
        if counter==0{
            timer.invalidate()
            print("Bitti")
        }
    }


}


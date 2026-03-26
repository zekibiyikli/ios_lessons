//
//  ViewController.swift
//  Catchkenny
//
//  Created by Mono on 26.03.2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var counter=10
    var counter2=1
    var baseTimer = Timer()
    var baseTimer2 = Timer()
    var showKennyIndex=0
    var kennyList=[UIImageView]()
    var resultScore=0

    override func viewDidLoad() {
        super.viewDidLoad()
        kennyList=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]

        checkHighScore()
        startTimer()
        // Do any additional setup after loading the view.
    }
    
    func resetGame(){
        kennyList[showKennyIndex].alpha=0
        resultScore=0
        counter=10
        counter2=1
        showKennyIndex=0
        checkHighScore()
        startTimer()
    }
    
    func checkHighScore(){
        let hs=UserDefaults.standard.object(forKey: "HighScore") as? Int
        highScore.text="HighScore: \(hs ?? 0)"
    }
    
    func controlHighScore(){
        let hs=UserDefaults.standard.object(forKey: "HighScore") as? Int
        
        if (hs ?? 0)<resultScore{
            UserDefaults.standard.set(resultScore, forKey: "HighScore")
            highScore.text="HighScore: \(resultScore)"
        }
    }
    
    func startTimer(){
        baseTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        showRandomKenny()
    }
    
    func finishTimer(){
        baseTimer2.invalidate()
        controlHighScore()
        let alert = UIAlertController(title: "Game Over",
                                      message: "Skorunuz => \(resultScore)",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Yeniden?", style: .default) { _ in
            self.resetGame()
        }

        let cancelAction = UIAlertAction(title: "Kapat", style: .cancel) { _ in
            exit(0)
        }

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    
    func showRandomKenny(){
        counter2=1
        showKennyIndex = Int.random(in: 0...8)
        kennyList[showKennyIndex].alpha=1
        
        baseTimer2=Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(timerFunction2), userInfo: nil, repeats: true)

    }
    
    @IBAction func kennyClicked(_ sender: Any) {
        if let gesture = sender as? UITapGestureRecognizer,
           let tappedView = gesture.view {
            
            if (tappedView.tag == showKennyIndex+1){
                resultScore=resultScore+1
                score.text="Score: \(resultScore)"
            }
            
        }
    }
    
    @objc func timerFunction(){
        counter-=1
        timer.text = String(counter)
        if counter==0{
            baseTimer.invalidate()
            finishTimer()
        }
    }
    @objc func timerFunction2(){
        counter2-=1
        if counter2==0{
            baseTimer2.invalidate()
            kennyList[showKennyIndex].alpha=0
            showRandomKenny()
        }
    }

}


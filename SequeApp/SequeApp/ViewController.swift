//
//  ViewController.swift
//  SequeApp
//
//  Created by Mono on 26.03.2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad func called")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear func called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear func called")
    }

    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear func called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear func called")
    }

    @IBAction func btnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSecondVC", sender: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.dataFromFirstVC = "Merhaba iOS 🚀"
        }
    }
}


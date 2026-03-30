//
//  ViewController.swift
//  SpecialApps
//
//  Created by Zeki Mac on 30.03.2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnDarkModeClicked(_ sender: Any) {
        performSegue(withIdentifier: "toDarkModeVC", sender: nil)
    }
    @IBAction func btnFaceRecognizationClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFaceRecognizationVC", sender: nil)
    }
    @IBAction func btnKeyboardClicked(_ sender: Any) {
        performSegue(withIdentifier: "toKeyboardVC", sender: nil)
    }
}


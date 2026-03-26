//
//  ViewController.swift
//  AlertMessage
//
//  Created by Mono on 26.03.2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnClicked(_ sender: Any) {
        showDialog()
    }
    
    func showDialog(){
        let alert = UIAlertController(title: "Error", message: "Message", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {(UIAlertAction) in
            print("Button Clicked")
        } 
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


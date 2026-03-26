//
//  ViewController.swift
//  BasicOperations
//
//  Created by Mono on 26.03.2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func saveData(){
        UserDefaults.standard.set("Zeki", forKey: "name")
    }
    
    func getData(){
        UserDefaults.standard.object(forKey: "name")
    }
    
    func removeData(){
        UserDefaults.standard.removeObject(forKey: "name")
    }


}


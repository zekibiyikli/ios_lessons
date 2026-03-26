//
//  SecondViewController.swift
//  SequeApp
//
//  Created by Mono on 26.03.2026.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textName: UILabel!
    var dataFromFirstVC: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFromFirstVC ?? "")
        // Do any additional setup after loading the view.
    }
    
}

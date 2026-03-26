//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Mono on 26.03.2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(funcClicked))
        image.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func funcClicked(){
        print("Clicked")
    }


}


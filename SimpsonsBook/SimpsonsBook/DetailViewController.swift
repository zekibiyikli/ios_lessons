//
//  DetailViewController.swift
//  SimpsonsBook
//
//  Created by Mono on 27.03.2026.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var jobLabel: UILabel!
    
    var chosenSimpson: Simpsons?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text=chosenSimpson?.name
        imageView.image=chosenSimpson?.image
        jobLabel.text=chosenSimpson?.detail
    }
    

}

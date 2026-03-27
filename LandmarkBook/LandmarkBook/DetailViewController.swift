//
//  DetailViewController.swift
//  LandmarkBook
//
//  Created by Mono on 27.03.2026.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var selectedName=""
    var selectedImage=UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text=selectedName
        image.image=selectedImage
    }
    

}

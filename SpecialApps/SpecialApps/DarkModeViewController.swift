//
//  DarkModeViewController.swift
//  SpecialApps
//
//  Created by Zeki Mac on 30.03.2026.
//

import UIKit

class DarkModeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        overrideUserInterfaceStyle = .dark // telefona bakmadan direkt dark yapar
        //sadece bu sayfada dark yapar bütün uygulamada yapmak için info ya User Interface Style => Dark yapılabilir
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //like onresume
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            print("Dark")
        }else{
            print("Light")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        //on change
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            print("Dark")
        }else{
            print("Light")
        }
    }


}

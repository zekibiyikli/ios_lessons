//
//  FaceRecognizationViewController.swift
//  SpecialApps
//
//  Created by Zeki Mac on 30.03.2026.
//

import UIKit
import LocalAuthentication

class FaceRecognizationViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        let authContext = LAContext()
        var error: NSError?
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?"){ (success,error) in
                if success == true {
                    print("Başarılı")
                }else{
                    print("Başarısız")
                }
            }
        }
    }
    

}

//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Zeki Mac on 30.03.2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    
    var tryText: String?
    var usdText: String?
    var gbpText: String?
    var eurText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnGetRate(_ sender: Any) {
        getRate()
    }
    
    func getRate() {
        let url = URL(string:"https://data.fixer.io/api/latest?access_key=d126f529cacdc1c5c8703ede23fe44b4")
        let session=URLSession.shared
        let task = session.dataTask(with: url!){(data,response,error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
            }else{
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async{
                            if let rates = jsonResponse["rates"] as? Dictionary<String,Any>{
                                if let eur = rates["EUR"] as? Double{
                                    self.eurLabel.text = "Euro: \(eur)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let tl = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(tl)"
                                }
                            }
                        }
                    }catch {
                        print("Error")
                    }
                }
            }
        }
        task.resume()
    }
        
}


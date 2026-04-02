//
//  ViewController.swift
//  Threading
//
//  Created by Zeki Mac on 2.04.2026.
//

import UIKit
import SwiftUI

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text="\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func exmapleThread(){
        DispatchQueue.main.async { // Anathredde async işlem yapar
            
        }
        
        DispatchQueue.global().async {// arka planda başka threadde yapar
            DispatchQueue.main.async { // iç içe kullanılabilir
                
            }
        }
    }
    
    func exmapleAsync(){
        //Asenkron olarak resim yükleme
        AsyncImage(url: URL(string: "")){ image in
            
        } placeholder: {
            //indirmeden önceki resmi gösterir
            ProgressView()
        }
    }


}


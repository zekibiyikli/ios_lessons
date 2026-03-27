//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Mono on 27.03.2026.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var landmarkNames=[String]()
    var landmarkImages=[UIImage]()
    var chosenNames:String?
    var chosenImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        landmarkNames.append("Collesium")
        landmarkNames.append("Great Wall")
        landmarkNames.append("Kremlin")
        landmarkImages.append(UIImage(named:"collesium.jpg")!)
        landmarkImages.append(UIImage(named:"greatwall.jpg")!)
        landmarkImages.append(UIImage(named:"kremlin.jpg")!)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content=cell.defaultContentConfiguration()
        content.secondaryText=landmarkNames[indexPath.row]
        cell.contentConfiguration=content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenNames = landmarkNames[indexPath.row]
        chosenImage = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            self.landmarkNames.remove(at: indexPath.row)
            self.landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at:[indexPath], with: .fade)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.selectedImage = chosenImage!
            detailVC.selectedName = chosenNames!
        }
    }


}


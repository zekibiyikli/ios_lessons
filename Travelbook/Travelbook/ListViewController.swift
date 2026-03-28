//
//  ListViewController.swift
//  Travelbook
//
//  Created by Zeki Mac on 28.03.2026.
//

import UIKit
import CoreData

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray=[String]()
    var idArray=[UUID]()
    var chosenID:UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newPlace"), object: nil)
    }
    
    @objc func getData(){
        titleArray.removeAll()
        idArray.removeAll()
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        let request:NSFetchRequest<NSFetchRequestResult>=NSFetchRequest.init(entityName: "Places")
        request.returnsObjectsAsFaults=false
        
        do{
            let results = try context.fetch(request)
            if results.count>0{
                for item in results as! [NSManagedObject]{
                    if let title = item.value(forKey: "title") as? String{
                        titleArray.append(title)
                    }
                    if let id = item.value(forKey: "uuid") as? UUID{
                        idArray.append(id)
                    }
                    tableView.reloadData()
                }
            }
        }catch {
            print("Erro")
        }
        
    }
    
    @objc func addButtonTapped(){
        chosenID = nil
        performSegue(withIdentifier: "toMapController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text=titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenID=idArray[indexPath.row]
        performSegue(withIdentifier: "toMapController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapController" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.chosenId = chosenID
            
        }
    }
    
    


}

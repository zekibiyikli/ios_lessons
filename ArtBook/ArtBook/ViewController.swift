//
//  ViewController.swift
//  ArtBook
//
//  Created by Mono on 27.03.2026.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPaintingID:UUID?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add  , target: self, action: #selector(addButtonClicked))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newdata"), object: nil)
    }
    
    @objc  func getData(){
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            for item in results as! [NSManagedObject]{
                if let name = item.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                if let id = item.value(forKey: "uuid") as? UUID{
                    self.idArray.append(id)
                }
                self.tableView.reloadData()
            }
        }catch{
            print("Error")
        }
        
    }
    
    func deleteItem(indexPath:IndexPath){
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context=appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        let idString = idArray[indexPath.row].uuidString
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", idString)
        fetchRequest.returnsObjectsAsFaults=false
        do{
            let results = try context.fetch(fetchRequest)
            if results.count>0{
                let item = results[0] as! NSManagedObject
                context.delete(item)
                nameArray.remove(at: indexPath.row)
                idArray.remove(at: indexPath.row)
                tableView.deleteRows(at:[indexPath], with: .fade)
                try context.save()
            }
        }catch{
            print("Error")
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        var content=cell.defaultContentConfiguration()
        content.secondaryText=nameArray[indexPath.row]
        cell.contentConfiguration=content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPaintingID=idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            deleteItem(indexPath: indexPath)
        }
    }

    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.chosenPaintingId=selectedPaintingID
        }
    }


}


//
//  DetailViewController.swift
//  ArtBook
//
//  Created by Mono on 27.03.2026.
//

import UIKit
import CoreData

class DetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    
    var chosenPaintingId:UUID? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        image.isUserInteractionEnabled=true
        let imageTapRecognizer=UITapGestureRecognizer(target: self, action: #selector(selectImage))
        image.addGestureRecognizer(imageTapRecognizer)
        
        if chosenPaintingId == nil {
            nameText.text=""
            artistText.text=""
            yearText.text=""
            btnSave.isHidden=false
            btnSave.isEnabled=false
        }else{
            btnSave.isHidden=true
            getData()
        }
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        let idString = chosenPaintingId?.uuidString ?? ""
        
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", idString)
        fetchRequest.returnsObjectsAsFaults=false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count>0{
                let item = results[0] as! NSManagedObject
                if let name=item.value(forKey: "name") as? String{
                    nameText.text=name
                }
                if let artist=item.value(forKey: "artist") as? String{
                    artistText.text=artist
                }
                if let year=item.value(forKey: "year") as? Int{
                    yearText.text=String(year)
                }
                if let imageData=item.value(forKey: "image") as? Data{
                    image.image = UIImage(data: imageData)
                }

            }
        }catch{
            print("Error")
        }
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }

    @IBAction func saveClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newPainting.setValue(nameText.text, forKey: "name")
        newPainting.setValue(artistText.text, forKey: "artist")
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "uuid")
        let data = image.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        do{
            try context.save()
        }catch{
            print("Error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newdata"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image=info[.editedImage] as? UIImage
        btnSave.isEnabled=true
        self.dismiss(animated: true)
    }
}

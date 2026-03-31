//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Zeki Mac on 31.03.2026.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var postId=UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        loadImage()
    }
    
    func loadImage(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaRef = storageRef.child("media").child("\(postId).jpg")
        
        if let uploadData = image.image?.jpegData(compressionQuality: 0.5){
            mediaRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error{
                    self.makeAlert(title:"Error",description:error.localizedDescription)
                }else{
                    mediaRef.downloadURL() { (url, error) in
                        if let url = url{
                            self.loadData(imageUrl: url.absoluteString)
                        }
                    }
                }
            }
        }
    }
    
    func loadData(imageUrl:String){
        let store = Firestore.firestore()
        let firestorePost = [
            "imageUrl":imageUrl,
            "date":FieldValue.serverTimestamp(),
            "postedBy":Auth.auth().currentUser!.email!,
            "comment":comment.text ?? "",
            "likes":0
        ] as [String:Any]
        store.collection("posts").addDocument(data: firestorePost,completion: { (error) in
            if error != nil{
                self.makeAlert(title: "Error", description: error!.localizedDescription)
            }else{
                self.image.image = UIImage(named: "selectImage")
                self.comment.text =  ""
                self.tabBarController?.selectedIndex = 0
            }
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert(title:String,description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

    

}

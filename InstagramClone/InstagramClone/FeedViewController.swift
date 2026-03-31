//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by Zeki Mac on 31.03.2026.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts=[Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFireStore()
    }
    
    func getDataFromFireStore(){
        let firestore=Firestore.firestore()
        firestore.collection("posts").order(by: "date",descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil{
                self.makeAlert(title: "Error", description: error!.localizedDescription)
            }else{
                if snapshot?.isEmpty == false{
                    self.posts.removeAll()
                    for item in snapshot!.documents{
                        let basePost=Post(
                            uuid: item.documentID,
                            imageUrl: item.get("imageUrl") as? String ?? "",
                            date: item.get("date") as? String ?? "",
                            postedBy: item.get("postedBy") as? String ?? "",
                            comment: item.get("comment") as? String ?? "",
                            likes: item.get("likes") as? Int ?? 0,
                        )
                        self.posts.append(basePost)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = self.posts[indexPath.row].postedBy
        cell.commentLabel.text = self.posts[indexPath.row].comment
        cell.likeCountLabel.text = String(self.posts[indexPath.row].likes)
        cell.cellImage.sd_setImage(with: URL(string:self.posts[indexPath.row].imageUrl))
        cell.post=self.posts[indexPath.row]
        return cell
    }
    
    func makeAlert(title:String,description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }

}

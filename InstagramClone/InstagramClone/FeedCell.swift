//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Zeki Mac on 31.03.2026.
//

import UIKit
import FirebaseFirestore

class FeedCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    var post:Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeBtnClicked(_ sender: Any) {
        let firestore=Firestore.firestore()
        let likeCount = ((Int(likeCountLabel.text ?? "0") ?? 0)+1) as Any
        firestore.collection("posts").document(post!.uuid).updateData(["likes":likeCount])
    }
    
    
}

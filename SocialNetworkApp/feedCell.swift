//
//  feedCell.swift
//  SocialNetworkApp
//
//  Created by Madan on 3/4/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit
import Firebase

class feedCell: UITableViewCell {

    @IBOutlet weak var profileImg : UIImageView!
    @IBOutlet weak var profileLabel : UILabel!
    @IBOutlet weak var postedImage : UIImageView!
    @IBOutlet weak var postedTextView : UITextView!
    @IBOutlet weak var likes : UILabel!
    @IBOutlet weak var likesImage : UIImageView!
    
    var likesRef : FIRDatabaseReference!
    var post : Post!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likesImageTapped))
        gestureRecognizer.numberOfTapsRequired = 1
        likesImage.isUserInteractionEnabled = true
        likesImage.addGestureRecognizer(gestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(post : Post, img : UIImage? = nil) {
        self.post = post
        self.postedTextView.text = post.caption
        self.likes.text = String(post.likes)
        likesRef = DatabaseService.ds.REF_DB_USER_CURRENT.child("likes").child(post.postKey)
        if img != nil {
            self.postedImage.image = img;
        } else {
            let urlPath = FIRStorage.storage().reference(forURL: post.imageURL)
            urlPath.data(withMaxSize: 2*1024*1024, completion: { (data, error) in
                if error != nil {
                    print("Downloading image from storage failed")
                } else {
                    if let data = data {
                        let img = UIImage(data: data)
                        self.postedImage.image = img
                        FeedVC.imageCache.setObject(img!, forKey: post.imageURL as NSString)
                    }
                }
            })
        }
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            print("in cell likes")
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "empty-heart")
            } else {
                self.likesImage.image = UIImage(named: "filled-heart")
            }
        })
        
    }

    
    func likesImageTapped(sender : UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            print("in gesture likes")
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likesImage.image = UIImage(named: "empty-heart")
                 self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
            }
        })

    }
}

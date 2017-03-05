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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(post : Post, img : UIImage? = nil) {
        self.postedTextView.text = post.caption
        self.likes.text = String(post.likes)
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
        
    }

}

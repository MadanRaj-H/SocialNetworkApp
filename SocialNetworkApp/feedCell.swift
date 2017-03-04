//
//  feedCell.swift
//  SocialNetworkApp
//
//  Created by mh53653 on 3/4/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit

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

}

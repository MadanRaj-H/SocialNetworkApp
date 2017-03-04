//
//  RoundImageView.swift
//  SocialNetworkApp
//
//  Created by mh53653 on 3/4/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = layer.bounds.width / 2.0 ;
    }
}

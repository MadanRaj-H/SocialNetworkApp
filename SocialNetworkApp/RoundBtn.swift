//
//  RoundBtn.swift
//  SocialNetworkApp
//
//  Created by mh53653 on 3/2/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit

class RoundBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = layer.bounds.width / 2.0 ;
        imageView?.contentMode = .scaleAspectFit;
    }

}

//
//  FancyBtn.swift
//  SocialNetworkApp
//
//  Created by Madan on 3/2/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit
@IBDesignable
class FancyBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    @IBInspectable var radiusValue : CGFloat = 0.0 {
        didSet{
            setupUI();
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupUI()
    }
    
    func setupUI(){
       layer.cornerRadius = radiusValue
    }
}


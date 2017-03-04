//
//  FancyField.swift
//  SocialNetworkApp
//
//  Created by Madan on 3/2/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit

class FancyField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.borderWidth = 1.0;
        layer.cornerRadius = 2.0;
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect { // For placeholder
        return bounds.offsetBy(dx: 10.0, dy: 0.0);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect { // For editing
        return bounds.offsetBy(dx: 10.0, dy: 0.0);
    }
    
}

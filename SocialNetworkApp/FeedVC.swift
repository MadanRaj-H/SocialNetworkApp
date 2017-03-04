//
//  FeedVC.swift
//  SocialNetworkApp
//
//  Created by Madan on 3/4/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        let value = KeychainWrapper.standard.removeObject(forKey: USER_KEY_ID)
        print("User key removed from keychain \(value)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}

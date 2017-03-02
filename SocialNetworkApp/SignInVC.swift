//
//  ViewController.swift
//  SocialNetworkApp
//
//  Created by Madan on 3/1/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: FancyField!
    @IBOutlet weak var passwordTextField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        if let email = emailTextField.text , let pwd = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (result, error) in
                if error == nil {
                    print("Email user authenticated");
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (result, error) in
                        if error != nil {
                            print("Unable to login with firebase user email" + (error?.localizedDescription)!)
                        } else {
                            print("user created succesfully with email");
                        }
                    })
                }
            })
        }
    }
    @IBAction func facebookBtnPressed(_ sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result,error) in
            if error != nil {
                print("Unable to login" + (error?.localizedDescription)!)
            } else if result?.isCancelled == true {
                print("User cancelled the req")
            } else {
                print("Successfully authenticated with Facebook");
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.fireBaseAuth(credential)
            }
        }
    }
    
    func fireBaseAuth(_ credential : FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (result, error) in
            if error != nil {
                print("Unable to login to FIR Auth" + (error?.localizedDescription)!)
            }else {
                print("Successfully authenticated with FIR");
            }
        })
    }
}


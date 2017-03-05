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

class FeedVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var addImage: RoundImageView!
    @IBOutlet weak var captionTextField: UITextField!

    var posts = [Post]()
    var imagePicker : UIImagePickerController!
    var selectedImage = false;
    
    static var imageCache : NSCache<NSString,UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DatabaseService.ds.DB_BASE_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String,Any>{
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
                self.tableView.reloadData()
            }
        })
        
        
    }

    @IBAction func addPostBtnPressed(_ sender: Any) {
        guard let caption = captionTextField.text , caption != "" else {
            print("caption is must")
            return
        }
        
        guard let img = addImage.image , self.selectedImage != false else {
            print("image is must")
            return
        }
        
        if let imageData  = UIImageJPEGRepresentation(img, 0.2) {
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            let uuid = NSUUID().uuidString
            DatabaseService.ds.STORAGE_REF_POST_PICS.child(uuid).put(imageData, metadata: metaData, completion: { (metaData, error) in
                if error != nil {
                    print("Error while uploading")
                } else {
                    print("Successfully uploaded")
                }
            })
        }
    }
    @IBAction func addImageBtnTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image;
            selectedImage = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func signOutBtnPressed(_ sender: AnyObject) {
        //either add button on top of it or add tap gesture recognizer and make sure user interaction is enabled
        let value = KeychainWrapper.standard.removeObject(forKey: USER_KEY_ID)
        print("User key removed from keychain \(value)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? feedCell {
            let post = self.posts[indexPath.row]
            print("post : \(post.likes)")
            if let img = FeedVC.imageCache.object(forKey: post.imageURL as NSString) {
                cell.configureCell(post: post, img: img)
            } else {
               cell.configureCell(post: post)
            }
            return cell;
        } else {
            return feedCell()
        }
    }
}

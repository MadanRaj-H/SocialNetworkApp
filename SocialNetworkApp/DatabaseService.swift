//
//  DatabaseService.swift
//  SocialNetworkApp
//
//  Created by Madan on 3/4/17.
//  Copyright © 2017 madan. All rights reserved.
//

import UIKit
import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DatabaseService {
    
    static let ds = DatabaseService()
    
    private var _REF_DB_BASE = DB_BASE
    private var _REF_DB_USER = DB_BASE.child("users")
    private var _REF_DB_POSTS = DB_BASE.child("posts")
    
    private var _STORAGE_REF_POST_PICS = STORAGE_BASE.child("post-pics");
    
    var STORAGE_REF_POST_PICS : FIRStorageReference {
        return _STORAGE_REF_POST_PICS
    }
    
    var REF_DB_BASE : FIRDatabaseReference {
        return _REF_DB_BASE
    }
    
    var DB_BASE_USER : FIRDatabaseReference {
        return _REF_DB_USER
    }
    var DB_BASE_POSTS : FIRDatabaseReference {
        return _REF_DB_POSTS
    }
    
    func connectToFirDBUsers(uid : String, userData : Dictionary<String,String>){
        DB_BASE_USER.child(uid).updateChildValues(userData)
    }
    
    
}

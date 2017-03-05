//
//  Post.swift
//  SocialNetworkApp
//
//  Created by Madan on 3/5/17.
//  Copyright © 2017 madan. All rights reserved.
//

import Foundation
class Post {
    private var _caption : String!
    private var _imageURL : String!
    private var _likes : Int!
    private var _postKey : String!
    
    var likes : Int {
        return _likes
    }
    
    var caption : String {
        return _caption
    }
    
    var imageURL : String{
        return _imageURL
    }
    
    var postKey : String {
        return _postKey
    }
    
    init(postKey : String, postData : Dictionary<String,Any> ) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        if let imageURL = postData["imageURL"] as? String {
            self._imageURL = imageURL
        }
       
    }
}

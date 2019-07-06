//
//  UserContent.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/6/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import Foundation

class UserContent {
    
    var email : String
    var username : String
    var userImageProfileLink : String
    
    init(email : String, username: String , userImageProfileLink : String) {
        self.email = email
        self.username = username
        self.userImageProfileLink = userImageProfileLink
    }
    
    
}

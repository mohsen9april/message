//
//  Message.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import Foundation

class Message {
    
    var sender : String 
    var messageBody : String
    var email : String
    var username : String
    var usersImageProfileLink : String
    
    
    init(sender : String, messageBody: String, email : String , username : String , usersImageProfileLink : String ) {
        self.sender = sender
        self.messageBody = messageBody
        self.email = email
        self.username = username
        self.usersImageProfileLink = usersImageProfileLink
    }
}

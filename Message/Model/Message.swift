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
    
    init(sender : String, messageBody: String ) {
        self.sender = sender
        self.messageBody = messageBody
    }
}

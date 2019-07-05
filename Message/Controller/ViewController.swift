//
//  ViewController.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check Login
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "ToChatVC", sender: self)
        }
    }

    @IBAction func loginClicked(_ sender: Any) {
        performSegue(withIdentifier: "ToLoginVC", sender: self)
        
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        performSegue(withIdentifier: "ToRegisterVC", sender: self)
    }
    
}


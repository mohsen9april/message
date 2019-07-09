//
//  LoginVC.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func loginClicked(_ sender: Any) {
        
        activityIndicator.startAnimating()
        guard let email = emailTxt.text , !email.isEmpty else { return }
        guard let password = passwordTxt.text , !password.isEmpty else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, Error) in
            if let error = Error {
                print("Login Failed")
                debugPrint(error.localizedDescription)
                return
            }
            print("Login Successfuly!")
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "ToChatVC", sender: self)
        }
    }
}

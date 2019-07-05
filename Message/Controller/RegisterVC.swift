//
//  RegisterVC.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Register"
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        guard let email = emailTxt.text, !email.isEmpty else { return }
        guard let password = passwordTxt.text, !password.isEmpty else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, Error) in
            if let error = Error {
                print("Failed in Registraton user in Authentication !")
                debugPrint(error.localizedDescription)
                return
            }
            print("User Register Successfuly !")
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "ToChatVC", sender: self)
        }
    }
    
    
    
}

//
//  ChatVC.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITextFieldDelegate {
    
    let list = ["First Message" , "Second Message" , "Third Message"]
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTxt: UITextField!
    //@IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ChatVC"
        self.navigationItem.hidesBackButton = true
        
        // Create a Flexibale UIView to show Keyboard
        messageTxt.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        chatTableView.addGestureRecognizer(tap)
        
        //Set barButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            print("LogOut Successfuly !")
            navigationController?.popToRootViewController(animated: true)
        } catch  {
            print("Faild SignOut! ")
        }
    }
    
    @objc func tableViewTapped(){
        messageTxt.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 233
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
}

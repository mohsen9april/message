//
//  ChatVC.swift
//  Message
//
//  Created by Mohsen Abdollahi on 7/5/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITextFieldDelegate , UITableViewDelegate , UITableViewDataSource {

    let list = ["First Message" , "Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message Second Message "  , "Third Message", "Second Message" , "Third Message", "Second Message" , "Third Message"]
    
    var messageArray = [Message]()
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ChatVC"
        self.navigationItem.hidesBackButton = true
        
        
        //Register TableViewCell XibFle
        chatTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CellId")
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        // Set automatic dimensions for row height
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = UITableView.automaticDimension

        
        // Create a Flexibale UIView to show Keyboard
        messageTextField.delegate = self
        
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
        messageTextField.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            
            self.heightConstraint.constant = 343
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    //Save Messages to Database
    @IBAction func sendButtonClicked(_ sender: Any) {
        
        //First Disable Button and Text for
        messageTextField.isEnabled = false
        sendBtn.isEnabled = false
       
        guard let sender = Auth.auth().currentUser?.email else { return }
        guard let messageBody = messageTextField.text else { return }
        let messageDictionary = ["sender" : sender , "messageBody" : messageBody ]
        
        let MessageDB = Database.database().reference().child("Messages")
        MessageDB.childByAutoId().setValue(messageDictionary) { (Error, Reference ) in
            if let error = Error {
                print("Failed Save Messages to Database")
                debugPrint(error.localizedDescription)
                return
            }
            print("Messages Saved to Database Successfuly!")
            self.messageTextField.endEditing(true)
            self.messageTextField.isEnabled = true
            self.sendBtn.isEnabled = true
            self.messageTextField.text = ""
        }
    }
    
    
    
    
    
    
    
    
    //Configure TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! TableViewCell
        cell.messageBody.text = list[indexPath.row]
        cell.avatar.image = UIImage(named: "male-placeholder")
        return cell
    }
    
    // UITableViewAutomaticDimension calculates height of label contents/text
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

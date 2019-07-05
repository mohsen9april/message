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
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHieghtConstraint: NSLayoutConstraint!
    
    
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
    
    
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        print(123)
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

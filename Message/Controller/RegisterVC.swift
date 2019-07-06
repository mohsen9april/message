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
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        
        userProfile.layer.cornerRadius = userProfile.frame.width / 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tap.numberOfTapsRequired = 1
        userProfile.isUserInteractionEnabled = true
        userProfile.addGestureRecognizer(tap)
        
    }
    
    @objc func imageTapped(){
        lunchImagePicker()
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        guard let username = usernameTxt.text , !username.isEmpty else { return }
        guard let email = emailTxt.text, !email.isEmpty else { return }
        guard let password = passwordTxt.text, !password.isEmpty else { return }
        
        //Register user in Authentication
        Auth.auth().createUser(withEmail: email, password: password) { (result, Error) in
            if let error = Error {
                print("Failed in Registraton user in Authentication !")
                debugPrint(error.localizedDescription)
                return
            }
            print("User Register in Authentication Successfuly !")
            
            //MARK : - Save User Image to Database
            guard let image = self.userProfile.image else { return }
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            //let filename = NSUUID().uuidString
            let imageRef = Storage.storage().reference().child("usersImageProfile").child(username)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            imageRef.putData(uploadData, metadata: metadata, completion: { (metaData, Error) in
                if let error = Error{
                    print("Fiald to upload in Storage")
                    debugPrint(error.localizedDescription)
                    return
                }
                
                print("image uploaded in storage successfuly!")
                // now we retrive the url of image have uploaded.
                imageRef.downloadURL(completion: { (url, Error) in
                    if let error = Error{
                        print("Fiald to upload in Storage")
                        debugPrint(error.localizedDescription)
                        return
                    }
                    print("Url of image uploaded fetch successfuly !")
                    guard let url = url else { return }
                    print(url.absoluteString)
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "ToChatVC", sender: self)
                })
            })
        }
    }
}

extension RegisterVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func lunchImagePicker(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editingImage = info[.editedImage] as? UIImage else { return }
        userProfile.contentMode = .scaleAspectFill
        userProfile.image = editingImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

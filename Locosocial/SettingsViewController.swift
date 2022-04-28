//
//  SettingsViewController.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 26.04.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let avatar = UIImageView()
    let userNameLabel = UILabel()
    let logOutButton = UIButton()
    let imageLabel = UILabel()
    let documentIdLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)
        
        avatar.frame = CGRect(x: 30, y: 280, width: 150, height: 150)
        avatar.image = UIImage(named: "default-user-image")
        avatar.backgroundColor = .white
        avatar.layer.cornerRadius = 75
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        avatar.contentMode = .scaleAspectFit
        view.addSubview(avatar)
        
        imageLabel.frame = CGRect(x: 30, y: 280 + 155, width: 150, height: 30)
        imageLabel.text = "Press to select profile picture"
        imageLabel.font = UIFont(name: "Futura Medium", size: 10)
        imageLabel.textAlignment = .center
        imageLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        view.addSubview(imageLabel)
        
        userNameLabel.frame = CGRect(x: 200, y: 325, width: 200, height: 60)
        userNameLabel.text = ""
        userNameLabel.font = UIFont(name: "Futura Medium", size: 25)
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.minimumScaleFactor = 0.1
        userNameLabel.textAlignment = .center
        userNameLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        view.addSubview(userNameLabel)
        
        logOutButton.frame = CGRect(x: view.frame.width / 2 - 75, y: 500, width: 150, height: 40)
        logOutButton.tintColor = .systemRed
        logOutButton.configuration = .tinted()
        logOutButton.setTitle("Log Out", for: UIControl.State.normal)
        logOutButton.titleLabel?.font = UIFont(name: "Futura Medium", size: 20)
        logOutButton.addTarget(self, action: #selector(logOutPressed), for: UIControl.Event.touchDown)
        view.addSubview(logOutButton)
        
        getData()
        
        let avatarTapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarPressed))
        avatar.addGestureRecognizer(avatarTapGesture)
        
        
    }
    
    @objc func logOutPressed() {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLogInVC", sender: nil)
        } catch {
            
        }
        
    }
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("Usernames").addSnapshotListener { snapshot, error in
            if error == nil {
                if snapshot?.isEmpty != true {
                    for doc in snapshot!.documents {
                        let docomentID = doc.documentID
                        
                        if let email = doc.get("email") as? String {
                            if email == Auth.auth().currentUser?.email! {
                                if let username = doc.get("username") as? String {
                                    self.userNameLabel.text = "@\(username)"
                                    self.documentIdLabel.text = doc.documentID
                                    self.avatar.sd_setImage(with: URL(string: doc.get("picture") as! String))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func avatarPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatar.image = info[.editedImage] as? UIImage
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("ProfilePics")
        let uuid = UUID().uuidString
        
        if let data = avatar.image?.jpegData(compressionQuality: 0.5) {
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error == nil {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let profilePicRef = ["picture": imageUrl] as? [String : Any]
                            
                            let db = Firestore.firestore()
                            db.collection("Usernames").document(self.documentIdLabel.text!).setData(profilePicRef!, merge: true)
                        }
                    }
                }
            }
        }
        
        
        
        
        
        dismiss(animated: true)
    }

}

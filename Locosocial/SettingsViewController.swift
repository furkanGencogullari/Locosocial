//
//  SettingsViewController.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 26.04.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    let avatar = UIImageView()
    let userNameLabel = UILabel()
    let logOutButton = UIButton()
    let imageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)
        
        avatar.frame = CGRect(x: 30, y: 280, width: 150, height: 150)
        avatar.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        avatar.layer.cornerRadius = 75
        avatar.clipsToBounds = true
        view.addSubview(avatar)
        
        imageLabel.frame = CGRect(x: 30, y: 280 + 155, width: 150, height: 30)
        imageLabel.text = "Press to select profile picture"
        imageLabel.font = UIFont(name: "Futura Medium", size: 10)
        imageLabel.textAlignment = .center
        imageLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        view.addSubview(imageLabel)
        
        userNameLabel.frame = CGRect(x: 200, y: 325, width: 200, height: 60)
        userNameLabel.text = "@zeynepca"
        userNameLabel.font = UIFont(name: "Futura Medium", size: 25)
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
        
        
    }
    
    @objc func logOutPressed() {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLogInVC", sender: nil)
        } catch {
            
        }
        
    }

}

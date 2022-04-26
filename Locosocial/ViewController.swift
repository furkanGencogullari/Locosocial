//
//  ViewController.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 21.04.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class ViewController: UIViewController {
    
    let topView = UIView()
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialLight)
    let topBlur = UIVisualEffectView()
    let bottomView = UIView()
    let bottomBlur = UIVisualEffectView()
    
    let signUpButton = UIButton()
    let logInButton = UIButton()
    
    let bottomLabel = UILabel()
    let bottomLabel2 = UILabel()
    
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    let logo = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        
        
        //————— S H A P E S
        topBlur.frame = CGRect(x: view.frame.width / 2 - 150, y: -110, width: 300, height: 670)
        topBlur.effect = blurEffect
        topBlur.layer.cornerRadius = 40
        topBlur.clipsToBounds = true
        topBlur.alpha = 0.99
        view.addSubview(topBlur)
        
        topView.frame = CGRect(x: view.frame.width / 2 - 150, y: -110, width: 300, height: 670)
        topView.backgroundColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)
        topView.layer.cornerRadius = 40
        topView.clipsToBounds = true
        view.addSubview(topView)
        
        bottomBlur.frame = CGRect(x: view.frame.width / 2 - 150, y: 896 - 70, width: 300, height: 120)
        bottomBlur.effect = blurEffect
        bottomBlur.layer.cornerRadius = 40
        bottomBlur.clipsToBounds = true
        bottomBlur.alpha = 0.99
        view.addSubview(bottomBlur)
        
        bottomView.frame = CGRect(x: view.frame.width / 2 - 150, y: 896 - 70, width: 300, height: 120)
        bottomView.backgroundColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)
        bottomView.layer.cornerRadius = 40
        bottomView.clipsToBounds = true
        bottomView.isUserInteractionEnabled = true
        view.addSubview(bottomView)
        
        
        //————— L A B E L S
        bottomLabel.frame = CGRect (x: 0, y: 0, width: 300, height: 50)
        bottomLabel.textAlignment = .center
        bottomLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        bottomLabel.font = UIFont(name: "Futura Medium", size: 15)
        bottomLabel.text = "I don't have an account."
        bottomView.addSubview(bottomLabel)
        
        
        bottomLabel2.frame = CGRect(x: view.frame.width / 2 - 150, y: 896 - 70, width: 300, height: 50)
        bottomLabel2.textAlignment = .center
        bottomLabel2.textColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)
        bottomLabel2.font = UIFont(name: "Futura Medium", size: 15)
        bottomLabel2.text = "I have an account."
        bottomLabel2.layer.opacity = 0
        bottomLabel2.isHidden = true
        bottomLabel2.isUserInteractionEnabled = true
        view.addSubview(bottomLabel2)
        
        
        //————— B U T T O N S
        logInButton.frame = CGRect(x: view.frame.width / 2 - 280 / 2, y: 560 + 10, width: 280, height: 60)
        logInButton.tintColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)
        logInButton.configuration = .plain()
        logInButton.setTitle("Log In", for: UIControl.State.normal)
        logInButton.titleLabel?.font = UIFont(name: "Futura Medium", size: 20)
        logInButton.layer.cornerRadius = 30
        logInButton.isHidden = false
        logInButton.clipsToBounds = true
        logInButton.addTarget(self, action: #selector(logInPressed), for: UIControl.Event.touchDown)
        view.addSubview(logInButton)
        
        signUpButton.frame = CGRect(x: view.frame.width / 2 - 280 / 2, y: 560 + 80, width: 280, height: 60)
        signUpButton.tintColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)
        signUpButton.configuration = .plain()
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont(name: "Futura Medium", size: 20)
        signUpButton.layer.cornerRadius = 30
        signUpButton.clipsToBounds = true
        signUpButton.isHidden = true
        signUpButton.layer.opacity = 0
        signUpButton.addTarget(self, action: #selector(signInPressed), for: UIControl.Event.touchDown)
        view.addSubview(signUpButton)
        
        
        //————— T E X T   F I E L D S
        passwordTextField.frame = CGRect(x: 10, y: 670 - 70, width: 280, height: 60)
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)])
        passwordTextField.font = UIFont(name: "Futura Medium", size: 15)
        passwordTextField.textAlignment = .center
        passwordTextField.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        passwordTextField.layer.cornerRadius = 30
        passwordTextField.clipsToBounds = false
        passwordTextField.isSecureTextEntry = true
        topView.addSubview(passwordTextField)
        
        emailTextField.frame = CGRect(x: 10, y: 670 - 140, width: 280, height: 60)
        emailTextField.attributedPlaceholder = NSAttributedString(
        string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)])
        emailTextField.textColor = .white
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont(name: "Futura Medium", size: 15)
        emailTextField.textAlignment = .center
        emailTextField.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        emailTextField.layer.cornerRadius = 30
        emailTextField.clipsToBounds = false
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        topView.addSubview(emailTextField)
        
        usernameTextField.frame = CGRect(x: 10, y: 670 - 210, width: 280, height: 60)
        usernameTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 1, blue: 1, alpha: 1)])
        usernameTextField.textColor = .white
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont(name: "Futura Medium", size: 15)
        usernameTextField.textAlignment = .center
        usernameTextField.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        usernameTextField.layer.cornerRadius = 30
        usernameTextField.clipsToBounds = true
        usernameTextField.isHidden = false
        usernameTextField.layer.opacity = 0
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        topView.addSubview(usernameTextField)
        
        
        //————— G E S T U R E S
        let bottomTap = UITapGestureRecognizer(target: self, action: #selector(goUp))
        let bottomViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(goDown))
        
        bottomLabel2.addGestureRecognizer(bottomTap)
        bottomView.addGestureRecognizer(bottomViewTapGesture)
        
        logo.frame = CGRect(x: view.frame.width / 2 - 280 / 2, y: 150, width: 280, height: 100)
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = .clear
        view.addSubview(logo)

        
        
        
        
    }
        
    @objc func goDown() {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.logInButton.layer.opacity = 0
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { Timer in
            self.logInButton.isHidden = true
        }
        
        self.signUpButton.isHidden = false
        UIView.animate(withDuration: 1, delay: 0.3) {
            self.topView.frame = CGRect(x: self.view.frame.width / 2 - 150, y: -40, width: 300, height: 670)
            self.topBlur.frame = CGRect(x: self.view.frame.width / 2 - 150, y: -40, width: 300, height: 670)
            self.bottomView.frame = CGRect(x: self.view.frame.width / 2 - 150, y: 896, width: 300, height: 120)
            self.bottomBlur.frame = CGRect(x: self.view.frame.width / 2 - 150, y: 896, width: 300, height: 120)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { Timer in
            self.signUpButton.isHidden = false
            self.bottomLabel2.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3, delay: 1.3) {
            self.usernameTextField.layer.opacity = 1
            self.signUpButton.layer.opacity = 1
            self.bottomLabel2.layer.opacity = 1
        }
    }
    
    @objc func goUp() {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.usernameTextField.layer.opacity = 0
            self.signUpButton.layer.opacity = 0
            self.bottomLabel2.layer.opacity = 0
        }
        
        UIView.animate(withDuration: 1, delay: 0.3) {
            self.topView.frame = CGRect(x: self.view.frame.width / 2 - 150, y: -110, width: 300, height: 670)
            self.topBlur.frame = CGRect(x: self.view.frame.width / 2 - 150, y: -110, width: 300, height: 670)
            self.bottomView.frame = CGRect(x: self.view.frame.width / 2 - 150, y: 896 - 70, width: 300, height: 120)
            self.bottomBlur.frame = CGRect(x: self.view.frame.width / 2 - 150, y: 896 - 70, width: 300, height: 120)
        }
        
        UIView.animate(withDuration: 0.3, delay: 1.3) {
            self.logInButton.layer.opacity = 1
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { Timer in
            self.signUpButton.isHidden = true
            self.logInButton.isHidden = false
            self.bottomLabel2.isHidden = true
        }
    }
    
    
    @objc func signInPressed() {
        if emailTextField.text != "" && passwordTextField.text != "" && usernameTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                    alert.addAction(okButton)
                    self.present(alert, animated: true)
                } else {
                    let user = ["username": self.usernameTextField.text!,
                                "email": self.emailTextField.text!,
                                "picture": "image"] as [String : Any]
                    
                    let db = Firestore.firestore()
                    var ref: DocumentReference? = nil
                    ref = db.collection("Usernames").addDocument(data: user, completion: { error in
                        if error == nil {
                            self.performSegue(withIdentifier: "toTabBar", sender: nil)
                        }
                    })
                }
            }
        }
        
        
        
    }
    
    
    @objc func logInPressed() {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                    alert.addAction(okButton)
                    self.present(alert, animated: true)
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        
        }
    }
    
    


}


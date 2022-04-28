//
//  FeedViewController.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 21.04.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cardTableView: UITableView!
    let topLogo = UIImageView()
    let topAvatar = UIImageView()
    let blurEffect = UIBlurEffect(style: .light)
    let topBlurView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        tabBarController?.tabBar.scrollEdgeAppearance = appearance
        tabBarController?.tabBar.standardAppearance = appearance
        
        getData()
        
        topBlurView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 90)
        topBlurView.effect = blurEffect
        view.addSubview(topBlurView)
        
        
        
        topLogo.frame = CGRect(x: view.frame.width / 2 - 200 / 2, y: 38, width: 200, height: 50)
        topLogo.image = UIImage(named: "logo")
        topLogo.contentMode = .scaleAspectFit
        view.addSubview(topLogo)
        
        topAvatar.frame = CGRect(x: 40, y: 42, width: 40, height: 40)
        topAvatar.layer.cornerRadius = 40 / 2
        topAvatar.clipsToBounds = true
        topAvatar.contentMode = .scaleAspectFit
        topAvatar.backgroundColor = .white
        view.addSubview(topAvatar)
        
        
        
        
        cardTableView.dataSource = self
        cardTableView.delegate = self
        
        
        
        view.backgroundColor = UIColor (red: 225/255, green: 1, blue: 1, alpha: 1)
        cardTableView.backgroundColor = .clear

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = cardTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        return cell
    }
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("Usernames").addSnapshotListener { snapshot, error in
            if error == nil {
                if snapshot?.isEmpty != true {
                    for doc in snapshot!.documents {
                        if let email = doc.get("email") as? String {
                            if email == Auth.auth().currentUser?.email! {
                                    self.topAvatar.sd_setImage(with: URL(string: doc.get("picture") as! String))
                            
                            }
                        }
                    }
                }
            }
        }
    }
    


}

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
    @IBOutlet weak var topAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        topLogo.frame = CGRect(x: view.frame.width / 2 - 250 / 2, y: 0, width: 250, height: 90)
        topLogo.backgroundColor = .white
        
        topAvatar.layer.cornerRadius = 33 / 2
        topAvatar.clipsToBounds = true
        topAvatar.contentMode = .scaleAspectFit
        
        
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

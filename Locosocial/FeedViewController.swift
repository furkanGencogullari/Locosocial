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
import CoreLocation

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cardTableView: UITableView!
    let topLogo = UIImageView()
    let topAvatar = UIImageView()
    let blurEffect = UIBlurEffect(style: .light)
    let topBlurView = UIVisualEffectView()
    
    var avatarArray = [String]()
    var titleArray = [String]()
    var usernameArray = [String]()
    var userLongitudeArray = [CLLocationDegrees]()
    var userLatitudeArray = [CLLocationDegrees]()
    var userDescArray = [String]()
    var postedByArray = [String]()
    
    
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
        return postedByArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = cardTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.userImage.sd_setImage(with: URL(string: avatarArray[indexPath.row]))
        cell.userNameLabel.text = "@\(postedByArray[indexPath.row])"
        cell.userDesc.text = titleArray[indexPath.row]
        cell.userInDesc.text = userDescArray[indexPath.row]
        cell.latitude2 = userLatitudeArray[indexPath.row]
        cell.longitude2 = userLongitudeArray[indexPath.row]
        cell.userLocation = CLLocationCoordinate2D(latitude: userLatitudeArray[1], longitude: userLongitudeArray[1])
        
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
        db.collection("Posts").addSnapshotListener { snaphot, error in
            if error == nil {
                if snaphot?.isEmpty != true {
                    for doc in snaphot!.documents {
                        if let avatar = doc.get("postedByAvatar") as? String {
                            self.avatarArray.append(avatar)
                        }
                        if let title = doc.get("title") as? String {
                            self.titleArray.append(title)
                        }
                        if let latitude = doc.get("latitude") as? CLLocationDegrees {
                            self.userLatitudeArray.append(latitude)
                            print(latitude)
                            print(" L A T I T U D E ")
                        }
                        if let longitude = doc.get("longitude") as? CLLocationDegrees {
                            self.userLongitudeArray.append(longitude)
                            print(longitude)
                            print(" L O N G I T U D E ")
                        }
                        if let postedBy = doc.get("postedBy") as? String {
                            self.postedByArray.append(postedBy)
                        }
                        if let desc = doc.get("description") as? String {
                            self.userDescArray.append(desc)
                        }
                    }
                }
                self.cardTableView.reloadData()
            }
        }
    }
    


}

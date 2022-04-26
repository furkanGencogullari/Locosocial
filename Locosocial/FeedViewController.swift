//
//  FeedViewController.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 21.04.2022.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cardTableView: UITableView!
    let topLogo = UIImageView()
    @IBOutlet weak var topAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLogo.frame = CGRect(x: view.frame.width / 2 - 250 / 2, y: 0, width: 250, height: 90)
        topLogo.backgroundColor = .white
        
        topAvatar.layer.cornerRadius = 33 / 2
        topAvatar.clipsToBounds = true
        
        
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
    


}

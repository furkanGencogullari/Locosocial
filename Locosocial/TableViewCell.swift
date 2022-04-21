//
//  TableViewCell.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 21.04.2022.
//

import UIKit
import MapKit

class TableViewCell: UITableViewCell, MKMapViewDelegate {
    @IBOutlet weak var card: UIView!
    let layer1 = CALayer()
    let card2 = UIView()
    let layer2 = CAGradientLayer()
    let map = MKMapView()
    let userDesc = UILabel()
    let blurLayer = CALayer()
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    let blurView = UIVisualEffectView()
    let userInDesc = UILabel()
    let userImage = UIImageView()
    let userNameLabel = UILabel()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        let height = contentView.frame.height
        let width = contentView.frame.width
        
        contentView.backgroundColor = .clear
        
        
        
        
        
        
        card.isHidden = true
        
        card2.frame = CGRect(x: 0, y: 0, width: width * 0.75, height: height * 0.9)
        card2.layer.position = contentView.center
        card2.backgroundColor = .clear
        contentView.addSubview(card2)
        
        map.delegate = self
        map.frame = CGRect(x: card2.frame.width / 2 - (width * 0.70 / 2), y: 10, width: width * 0.70, height: height * 0.45)
        map.layer.cornerRadius = 40
    
        userInDesc.text = "I created amazing memories here. The food is really good and they have fancy wines to go with them."
        userInDesc.frame = CGRect(x: card2.frame.width / 2 - (width * 0.70 / 2), y: card2.frame.height / 2, width: width * 0.70, height: height * 0.45)
        userInDesc.numberOfLines = 5
        userInDesc.textColor = UIColor(red: (249/255) / 1.5, green: (220/255) / 1.5, blue: 1 / 1.5, alpha: 1)
        userInDesc.font = UIFont(name: "Futura Medium", size: 15)
        
        
        
        
        
        layer1.frame = CGRect(x: 0, y: 0, width: width * 0.75, height: height * 0.9)
        layer1.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1).cgColor
        layer1.cornerRadius = 40
        layer1.shadowOffset = CGSize(width: 5, height: 5)
        layer1.shadowColor = UIColor.black.cgColor
        layer1.shadowOpacity = 0.5
        card2.layer.addSublayer(layer1)
        layer1.addSublayer(userInDesc.layer)
        card2.addSubview(map)
        
        
        blurView.alpha = 0.6
        blurView.effect = blurEffect
        blurView.frame = card2.bounds
        blurView.layer.cornerRadius = 40
        blurView.clipsToBounds = true
        
        
        
        
        
        
        
        layer2.frame = CGRect(x: 0, y: 0, width: width * 0.75, height: height * 0.9)
        layer2.colors = [UIColor(red: 220/255, green: 1, blue: 1, alpha: 0.6).cgColor, UIColor(red: 249/255, green: 220/255, blue: 1, alpha: 0.6).cgColor]
        layer2.cornerRadius = 40
        // a d d   l a y e r   3
        card2.addSubview(blurView)
        card2.layer.addSublayer(layer2)
        
        userImage.image = UIImage(named: "zeynep")
        userImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        userImage.contentMode = .scaleAspectFit
        userImage.layer.cornerRadius = 80 / 2
        userImage.clipsToBounds = true
        
        userNameLabel.text = "@zeynepca"
        userNameLabel.frame = CGRect(x: 90, y: 0, width: 180, height: 80)
        userNameLabel.textAlignment = .left
        userNameLabel.textColor = UIColor(red: (249/255) / 1.5, green: (220/255) / 1.5, blue: 1 / 1.5, alpha: 1)
        userNameLabel.font = UIFont(name: "Futura Medium", size: 20)
        
        
        userDesc.text = "This place is amazing!!"
        userDesc.textAlignment = .center
        userDesc.textColor = .systemGray
        userDesc.frame = CGRect(x: 0, y: 0, width: width * 0.75, height: height * 0.9)
        userDesc.font = UIFont(name: "Futura Medium", size: 20)
        layer2.addSublayer(userDesc.layer)
        layer2.addSublayer(userNameLabel.layer)
        layer2.addSublayer(userImage.layer)
        
        
        
        
        
        
        
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(moveToLeft))
        card2.addGestureRecognizer(gesture)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
   @objc func moveToLeft() {
       let animation = CABasicAnimation(keyPath: "position")
       animation.fromValue = CGPoint(x: layer1.frame.origin.x + (layer1.frame.width/2), y: layer1.frame.origin.y + (layer1.frame.height/2))
       animation.toValue = CGPoint(x: layer1.frame.origin.x - (contentView.frame.width/2), y: layer1.frame.origin.y + (layer1.frame.height/2))
       animation.duration = 0.5
       animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
       animation.fillMode = .forwards
       animation.isRemovedOnCompletion = false
       animation.beginTime = 0
       layer2.add(animation, forKey: nil)
       blurView.layer.add(animation, forKey: nil)
       
       
       let rotationn = CABasicAnimation(keyPath: "transform.rotation")
       rotationn.fromValue = 0
       rotationn.toValue = 0.2
       rotationn.duration = 0.5
       rotationn.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
       rotationn.fillMode = .forwards
       rotationn.isRemovedOnCompletion = false
       rotationn.beginTime = 0
       layer2.add(rotationn, forKey: nil)
       
       
        
    }
    
    @objc func rotate() {
        
        
        
         
     }

}

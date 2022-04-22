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
    let scrollView = UIScrollView()
    var switcher = 0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        card.isHidden = true
        contentView.backgroundColor = .clear
        
        let height = contentView.frame.height
        let width = contentView.frame.width
        
        card2.frame = CGRect(x: 0, y: 0, width: width * 0.80, height: height * 0.95)
        card2.layer.position = contentView.center
        card2.backgroundColor = .clear
        contentView.addSubview(card2)
        
        map.delegate = self
        map.frame = CGRect(x: card2.frame.width / 2 - (width * 0.70 / 2), y: 10, width: width * 0.70, height: height * 0.45)
        map.layer.cornerRadius = 40
        
    
        userInDesc.text = "I created amazing memories here. The food is really good and they have fancy wines to go with them."
        userInDesc.textAlignment = .center
        userInDesc.frame = CGRect(x: card2.frame.width / 2 - (width * 0.70 / 2), y: card2.frame.height / 2 + 3, width: width * 0.70, height: height * 0.25)
        userInDesc.numberOfLines = 5
        userInDesc.backgroundColor = .clear
        userInDesc.textColor = UIColor(red: (249/255) / 1.5, green: (220/255) / 1.5, blue: 1 / 1.5, alpha: 1)
        userInDesc.font = UIFont(name: "Futura Medium", size: 15)
        
        
        layer1.frame = CGRect(x: 0, y: 0, width: width * 0.8, height: height * 0.95)
        layer1.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1).cgColor
        layer1.cornerRadius = 40
        layer1.shadowOffset = CGSize(width: 5, height: 5)
        layer1.shadowColor = UIColor.black.cgColor
        layer1.shadowOpacity = 0.5
        card2.layer.addSublayer(layer1)
        layer1.addSublayer(userInDesc.layer)
        card2.addSubview(map)
        
        scrollView.frame = CGRect(x: card2.frame.width / 2 - 150, y: card2.frame.height * 0.78, width: 300, height: 80)
        scrollView.layer.cornerRadius = 40
        scrollView.backgroundColor = UIColor(red: 0.9, green: 1, blue: 1, alpha: 1)
        scrollView.contentSize = CGSize(width: 380, height: 80)
        card2.addSubview(scrollView)
        
        let userImage1 = UIImageView()
        userImage1.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        userImage1.backgroundColor = .clear
        userImage1.image = UIImage(named: "cafe1")
        userImage1.layer.cornerRadius = 30
        userImage1.clipsToBounds = true
        scrollView.addSubview(userImage1)
        
        let userImage2 = UIImageView()
        userImage2.frame = CGRect(x: 80, y: 10, width: 60, height: 60)
        userImage2.backgroundColor = .clear
        userImage2.image = UIImage(named: "cafe2")
        userImage2.layer.cornerRadius = 30
        userImage2.clipsToBounds = true
        scrollView.addSubview(userImage2)
        
        let userImage3 = UIImageView()
        userImage3.frame = CGRect(x: 150, y: 10, width: 60, height: 60)
        userImage3.backgroundColor = .clear
        userImage3.image = UIImage(named: "cafe3")
        userImage3.layer.cornerRadius = 30
        userImage3.clipsToBounds = true
        scrollView.addSubview(userImage3)
        
        let userImage4 = UIImageView()
        userImage4.frame = CGRect(x: 220, y: 10, width: 60, height: 60)
        userImage4.backgroundColor = .clear
        userImage4.image = UIImage(named: "cafe4")
        userImage4.layer.cornerRadius = 30
        userImage4.clipsToBounds = true
        scrollView.addSubview(userImage4)
        
        let userImage5 = UIImageView()
        userImage5.frame = CGRect(x: 290, y: 10, width: 60, height: 60)
        userImage5.backgroundColor = .clear
        userImage5.image = nil
        userImage5.layer.cornerRadius = 30
        userImage5.clipsToBounds = true
        scrollView.addSubview(userImage5)
        
        let userImage6 = UIImageView()
        userImage6.frame = CGRect(x: 360, y: 10, width: 60, height: 60)
        userImage6.backgroundColor = .clear
        userImage6.image = nil
        userImage6.layer.cornerRadius = 30
        userImage6.clipsToBounds = true
        scrollView.addSubview(userImage6)
        
        
        
        
        
        
        
        layer2.frame = CGRect(x: 0, y: 0, width: width * 0.75, height: height * 0.9)
        layer2.colors = [UIColor(red: 0, green: 1, blue: 173/2, alpha: 0.2).cgColor, UIColor(red: 1, green: 0, blue: 157/255, alpha: 0.2).cgColor]
        layer2.startPoint = CGPoint(x: 0, y: 0)
        layer2.endPoint = CGPoint(x: 1, y: 1)
        layer2.cornerRadius = 40
        
        card2.addSubview(blurView)
        card2.layer.addSublayer(layer2)
        
        blurView.alpha = 0.85
        blurView.effect = blurEffect
        blurView.frame = layer2.bounds
        blurView.layer.cornerRadius = 40
        blurView.clipsToBounds = true
        
        userImage.image = UIImage(named: "zeynep")
        userImage.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        userImage.contentMode = .scaleAspectFit
        userImage.layer.cornerRadius = 80 / 2
        userImage.clipsToBounds = true
        
        userNameLabel.text = "@zeynepca"
        userNameLabel.frame = CGRect(x: 90, y: 0, width: 180, height: 80)
        userNameLabel.textAlignment = .left
        userNameLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        userNameLabel.font = UIFont(name: "Futura Medium", size: 20)
        
        
        userDesc.text = "This place is amazing!!"
        userDesc.textAlignment = .center
        userDesc.textColor = .white
        userDesc.frame = CGRect(x: 0, y: 0, width: width * 0.75, height: height * 0.9)
        userDesc.font = UIFont(name: "Futura Medium", size: 20)
        layer2.addSublayer(userDesc.layer)
        layer2.addSublayer(userNameLabel.layer)
        layer2.addSublayer(userImage.layer)
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(fonk))
        card2.addGestureRecognizer(gesture)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @objc func fonk() {
        if switcher == 0 {
            moveToLeft()
        } else if switcher == 1 {
            goBack()
        }
        
    }
    
   func moveToLeft() {
       let animation = CABasicAnimation(keyPath: "position")
       animation.fromValue = CGPoint(x: layer1.frame.origin.x + (layer1.frame.width/2), y: layer1.frame.origin.y + (layer1.frame.height/2))
       animation.toValue = CGPoint(x: layer1.frame.origin.x - (contentView.frame.width/2) - 80, y: layer1.frame.origin.y + (layer1.frame.height/2))
       animation.duration = 0.6
       animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
       animation.fillMode = .forwards
       animation.isRemovedOnCompletion = false
       animation.beginTime = 0
       layer2.add(animation, forKey: nil)
       blurView.layer.add(animation, forKey: nil)
       
       let rotationn = CABasicAnimation(keyPath: "transform.rotation")
       rotationn.fromValue = 0
       rotationn.toValue = 0.3
       rotationn.duration = 0.6
       rotationn.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
       rotationn.fillMode = .forwards
       rotationn.isRemovedOnCompletion = false
       rotationn.beginTime = 0
       blurView.layer.add(rotationn, forKey: nil)
       layer2.add(rotationn, forKey: nil)
       
       Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (_) in
           self.layer2.isHidden = true
           self.blurView.isHidden = true
       }
       
       switcher = 1
    }
    
    func goBack() {
        self.layer2.isHidden = false
        self.blurView.isHidden = false
        
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: layer1.frame.origin.x - (contentView.frame.width/2) - 80, y: layer1.frame.origin.y + (layer1.frame.height/2))
        animation.toValue = CGPoint(x: layer1.frame.origin.x + (layer1.frame.width/2), y: layer1.frame.origin.y + (layer1.frame.height/2))
        animation.duration = 0.6
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = 0
        layer2.add(animation, forKey: nil)
        blurView.layer.add(animation, forKey: nil)
        
        
        
        
        let rotationn = CABasicAnimation(keyPath: "transform.rotation")
        rotationn.fromValue = 0.3
        rotationn.toValue = 0
        rotationn.duration = 0.75
        rotationn.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationn.fillMode = .forwards
        rotationn.isRemovedOnCompletion = false
        rotationn.beginTime = 0
        blurView.layer.add(rotationn, forKey: nil)
        layer2.add(rotationn, forKey: nil)
        
        switcher = 0
     }
    

}

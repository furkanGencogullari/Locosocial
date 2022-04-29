//
//  TableViewCell.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 21.04.2022.
//

import UIKit
import MapKit
import CoreLocation

class TableViewCell: UITableViewCell, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var card: UIView!
    let backCard = CALayer()
    let baseCard = UIView()
    var userDesc = UILabel()
    let map = MKMapView()
    let userImagesScroll = UIScrollView()
    
    let userImage1 = UIImageView()
    let userImage2 = UIImageView()
    let userImage3 = UIImageView()
    let userImage4 = UIImageView()
    let userImage5 = UIImageView()
    let userImage6 = UIImageView()
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    let frontCardBlur = UIVisualEffectView()
    let frontCardColor = CAGradientLayer()
    
    var userTitle = UILabel()
    let avatar = UIImageView()
    let userNameLabel = UILabel()
    
    var frontCardIsInLeft = false
    
    var longitude = 0.0
    var latitude = 0.0
    
    let locationManager = CLLocationManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        card.isHidden = true
        contentView.backgroundColor = .clear
        
        //to use it later when creating views and layers.
        let height = contentView.frame.height
        let width = contentView.frame.width
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        map.delegate = self
        map.frame = CGRect(x: (width * 0.80 - width * 0.77) / 2, y: (width * 0.80 - width * 0.77) / 2, width: width * 0.77, height: height * 0.45)
        map.layer.cornerRadius = 38
        map.isUserInteractionEnabled = false
        
        
        baseCard.frame = CGRect(x: 0, y: 0, width: width * 0.80, height: height * 0.90)
        baseCard.layer.position = contentView.center
        baseCard.backgroundColor = .clear
        contentView.addSubview(baseCard)
        
        backCard.frame = CGRect(x: 0, y: 0, width: width * 0.8, height: height * 0.90)
        backCard.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1).cgColor
        backCard.cornerRadius = 40
        backCard.shadowOffset = CGSize(width: 5, height: 5)
        backCard.shadowColor = UIColor.black.cgColor
        backCard.shadowOpacity = 0.5
        backCard.shadowRadius = 4
        baseCard.layer.addSublayer(backCard)
        backCard.addSublayer(userDesc.layer)
        baseCard.addSubview(map)
        
    
        userDesc.text = ""
        userDesc.textAlignment = .center
        userDesc.frame = CGRect(x: baseCard.frame.width / 2 - (width * 0.70 / 2), y: baseCard.frame.height / 2 + 3, width: width * 0.70, height: height * 0.25)
        userDesc.numberOfLines = 5
        userDesc.backgroundColor = .clear
        userDesc.textColor = UIColor(red: (249/255) / 1.5, green: (220/255) / 1.5, blue: 1 / 1.5, alpha: 1)
        userDesc.font = UIFont(name: "Futura Medium", size: 15)
        
        
        userImagesScroll.frame = CGRect(x: baseCard.frame.width / 2 - 150, y: baseCard.frame.height * 0.78, width: 300, height: 80)
        userImagesScroll.layer.cornerRadius = 40
        userImagesScroll.backgroundColor = UIColor(red: 0.9, green: 1, blue: 1, alpha: 1)
        userImagesScroll.contentSize = CGSize(width: 380, height: 80)
        baseCard.addSubview(userImagesScroll)
        
        userImage1.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        userImage1.backgroundColor = .clear
        userImage1.layer.cornerRadius = 30
        userImage1.clipsToBounds = true
        userImagesScroll.addSubview(userImage1)
        
        userImage2.frame = CGRect(x: 80, y: 10, width: 60, height: 60)
        userImage2.backgroundColor = .clear
        userImage2.layer.cornerRadius = 30
        userImage2.clipsToBounds = true
        userImagesScroll.addSubview(userImage2)
        
        userImage3.frame = CGRect(x: 150, y: 10, width: 60, height: 60)
        userImage3.backgroundColor = .clear
        userImage3.layer.cornerRadius = 30
        userImage3.clipsToBounds = true
        userImagesScroll.addSubview(userImage3)
        
        userImage4.frame = CGRect(x: 220, y: 10, width: 60, height: 60)
        userImage4.backgroundColor = .clear
        userImage4.layer.cornerRadius = 30
        userImage4.clipsToBounds = true
        userImagesScroll.addSubview(userImage4)
        
        userImage5.frame = CGRect(x: 290, y: 10, width: 60, height: 60)
        userImage5.backgroundColor = .clear
        userImage5.layer.cornerRadius = 30
        userImage5.clipsToBounds = true
        userImagesScroll.addSubview(userImage5)
        
        userImage6.frame = CGRect(x: 360, y: 10, width: 60, height: 60)
        userImage6.backgroundColor = .clear
        userImage6.layer.cornerRadius = 30
        userImage6.clipsToBounds = true
        userImagesScroll.addSubview(userImage6)
        
        //Front card is made up from two peaces on top of each other.
        frontCardColor.frame = CGRect(x: 0, y: 0, width: width * 0.8, height: height * 0.9)
        frontCardColor.colors = [UIColor(red: 0, green: 1, blue: 173/255, alpha: 0.2).cgColor, UIColor(red: 1, green: 0, blue: 157/255, alpha: 0.2).cgColor]
        frontCardColor.startPoint = CGPoint(x: 0, y: 0)
        frontCardColor.endPoint = CGPoint(x: 1, y: 1)
        frontCardColor.cornerRadius = 40
        
        frontCardBlur.alpha = 0.85
        frontCardBlur.effect = blurEffect
        frontCardBlur.frame = frontCardColor.bounds
        frontCardBlur.layer.cornerRadius = 40
        frontCardBlur.clipsToBounds = true
        
        baseCard.addSubview(frontCardBlur)
        baseCard.layer.addSublayer(frontCardColor)
        
        
        avatar.image = UIImage()
        avatar.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = 80 / 2
        avatar.clipsToBounds = true
        
        userNameLabel.text = ""
        userNameLabel.layer.shadowRadius = 1.5
        userNameLabel.layer.shadowOpacity = 0.3
        userNameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        userNameLabel.layer.masksToBounds = false
        userNameLabel.frame = CGRect(x: 90, y: 0, width: 180, height: 80)
        userNameLabel.textAlignment = .left
        userNameLabel.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        userNameLabel.font = UIFont(name: "Futura Medium", size: 20)
        userNameLabel.adjustsFontSizeToFitWidth = true
        
        userTitle.text = ""
        userTitle.backgroundColor = .clear
        userTitle.layer.shadowColor = UIColor(red: 225/255, green: 1, blue: 1, alpha: 1).cgColor
        userTitle.layer.shadowRadius = 4
        userTitle.layer.shadowOpacity = 1
        userTitle.layer.shadowOffset = CGSize(width: 0, height: 0)
        userTitle.layer.masksToBounds = false
        userTitle.textAlignment = .center
        userTitle.textColor = UIColor(red: 255/255, green: 118/255, blue: 202/255, alpha: 1)
        userTitle.frame = CGRect(x: width * 0.05, y: 150, width: width * 0.8 - width * 0.1, height: 100)
        userTitle.font = UIFont(name: "Futura Medium", size: 20)
        userTitle.numberOfLines = 3
        
        frontCardColor.addSublayer(userTitle.layer)
        frontCardColor.addSublayer(userNameLabel.layer)
        frontCardColor.addSublayer(avatar.layer)
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(animateFrontCard))
        baseCard.addGestureRecognizer(gesture)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func animateFrontCard() {
        if frontCardIsInLeft == false {
            moveToLeft()
        } else if frontCardIsInLeft == true {
            goBack()
        }
    }
    
   func moveToLeft() {
       let positionAnimation = CABasicAnimation(keyPath: "position")
       positionAnimation.fromValue = CGPoint(x: backCard.frame.origin.x + (backCard.frame.width/2), y: backCard.frame.origin.y + (backCard.frame.height/2))
       positionAnimation.toValue = CGPoint(x: backCard.frame.origin.x - (contentView.frame.width/2) - 80, y: backCard.frame.origin.y + (backCard.frame.height/2))
       positionAnimation.duration = 0.6
       positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
       positionAnimation.fillMode = .forwards
       positionAnimation.isRemovedOnCompletion = false
       positionAnimation.beginTime = 0
       frontCardColor.add(positionAnimation, forKey: nil)
       frontCardBlur.layer.add(positionAnimation, forKey: nil)
       
       let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
       rotationAnimation.fromValue = 0
       rotationAnimation.toValue = 0.3
       rotationAnimation.duration = 0.6
       rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
       rotationAnimation.fillMode = .forwards
       rotationAnimation.isRemovedOnCompletion = false
       rotationAnimation.beginTime = 0
       frontCardBlur.layer.add(rotationAnimation, forKey: nil)
       frontCardColor.add(rotationAnimation, forKey: nil)
       
       Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (_) in
           self.frontCardColor.isHidden = true
           self.frontCardBlur.isHidden = true
       }
       
       frontCardIsInLeft = true
    }
    
    func goBack() {
        self.frontCardColor.isHidden = false
        self.frontCardBlur.isHidden = false
        
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = CGPoint(x: backCard.frame.origin.x - (contentView.frame.width/2) - 80, y: backCard.frame.origin.y + (backCard.frame.height/2))
        positionAnimation.toValue = CGPoint(x: backCard.frame.origin.x + (backCard.frame.width/2), y: backCard.frame.origin.y + (backCard.frame.height/2))
        positionAnimation.duration = 0.6
        positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        positionAnimation.fillMode = .forwards
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.beginTime = 0
        frontCardColor.add(positionAnimation, forKey: nil)
        frontCardBlur.layer.add(positionAnimation, forKey: nil)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.3
        rotationAnimation.toValue = 0
        rotationAnimation.duration = 0.75
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.beginTime = 0
        frontCardBlur.layer.add(rotationAnimation, forKey: nil)
        frontCardColor.add(rotationAnimation, forKey: nil)
        
        frontCardIsInLeft = false
     }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        map.addAnnotation(annotation)
    }
}

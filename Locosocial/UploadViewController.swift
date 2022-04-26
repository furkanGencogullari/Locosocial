//
//  UploadViewController.swift
//  Locosocial
//
//  Created by Furkan Gençoğulları on 22.04.2022.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseFirestore

class UploadViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    let scrollView = UIScrollView()
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    let titleField = UITextField()
    let descField = UITextView()
    
    let imageScroll = UIScrollView()
    let addImageButton = UIButton()
    let imagePlaceholder = UILabel()
    
    let uploadButton = UIButton()
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    
    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    let imageView3 = UIImageView()
    let imageView4 = UIImageView()
    let imageView5 = UIImageView()
    let imageView6 = UIImageView()
    
    var chosenLongitude = 0.0
    var chosenLatitude = 0.0
    
    var imageUrlArray = [String]()
    
    let username = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.5, alpha: 1)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        view.addSubview(scrollView)
        
        
        mapView.frame = CGRect(x: view.frame.width / 2 - 190, y: 0, width: 380, height: 400)
        mapView.delegate = self
        mapView.layer.cornerRadius = 40
        scrollView.addSubview(mapView)
        
        let mapTouchGesture = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation))
        mapTouchGesture.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(mapTouchGesture)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        titleField.frame = CGRect(x: view.frame.width / 2 - 190, y: 415, width: 380, height: 80)
        titleField.layer.cornerRadius = 40
        titleField.backgroundColor = .clear
        titleField.textAlignment = .center
        titleField.font = UIFont(name: "Futura Medium", size: 20)
        titleField.placeholder = "Title"
        createBackground(Frame: titleField.frame, View: titleField)
        scrollView.addSubview(titleField)
        
        
        descField.delegate = self
        descField.frame = CGRect(x: view.frame.width / 2 - 190, y: 510, width: 380, height: 300)
        descField.text = "Description"
        descField.backgroundColor = .clear
        descField.textColor = .lightGray
        descField.layer.cornerRadius = 40
        descField.textAlignment = .center
        descField.font = UIFont(name: "Futura Medium", size: 17)
        createBackground(Frame: descField.frame, View: descField)
        scrollView.addSubview(descField)
        
        
        imageScroll.frame = CGRect(x: view.frame.width / 2 - 190, y: 825, width: 380, height: 80)
        imageScroll.backgroundColor = .clear
        imageScroll.contentSize = CGSize(width: 500, height: 80)
        imageScroll.layer.cornerRadius = 40
        createBackground(Frame: imageScroll.frame, View: imageScroll)
        scrollView.addSubview(imageScroll)
        
        
        imagePlaceholder.frame = CGRect(x: 40, y: 10, width: 360, height: 60)
        imagePlaceholder.textColor = UIColor.lightGray
        imagePlaceholder.text = "Add Images"
        imagePlaceholder.font = UIFont(name: "Futura Medium", size: 17)
        imageScroll.addSubview(imagePlaceholder)
        
        
        addImageButton.frame = CGRect(x: view.frame.width / 2 - 190 + 300, y: 825, width: 80, height: 80)
        addImageButton.tintColor = .blue
        addImageButton.configuration = .filled()
        addImageButton.layer.cornerRadius = 40
        addImageButton.clipsToBounds = true
        addImageButton.backgroundColor = .darkGray
        addImageButton.setImage(UIImage(systemName: "plus.circle.fill"), for: UIControl.State.normal)
        addImageButton.titleLabel?.text = nil
        addImageButton.addTarget(self, action: #selector(addImageButtonPressed), for: UIControl.Event.touchDown)
        scrollView.addSubview(addImageButton)
        
        
        
        imageView1.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        imageView1.backgroundColor = .clear
        imageView1.image = nil
        imageView1.layer.cornerRadius = 30
        imageView1.clipsToBounds = true
        imageScroll.addSubview(imageView1)
        
        imageView2.frame = CGRect(x: 80, y: 10, width: 60, height: 60)
        imageView2.backgroundColor = .clear
        imageView2.image = nil
        imageView2.layer.cornerRadius = 30
        imageView2.clipsToBounds = true
        imageScroll.addSubview(imageView2)
        
        imageView3.frame = CGRect(x: 150, y: 10, width: 60, height: 60)
        imageView3.backgroundColor = .clear
        imageView3.image = nil
        imageView3.layer.cornerRadius = 30
        imageView3.clipsToBounds = true
        imageScroll.addSubview(imageView3)
        
        imageView4.frame = CGRect(x: 220, y: 10, width: 60, height: 60)
        imageView4.backgroundColor = .clear
        imageView4.image = nil
        imageView4.layer.cornerRadius = 30
        imageView4.clipsToBounds = true
        imageScroll.addSubview(imageView4)
        
        imageView5.frame = CGRect(x: 290, y: 10, width: 60, height: 60)
        imageView5.backgroundColor = .clear
        imageView5.image = nil
        imageView5.layer.cornerRadius = 30
        imageView5.clipsToBounds = true
        imageScroll.addSubview(imageView5)
        
        imageView6.frame = CGRect(x: 360, y: 10, width: 60, height: 60)
        imageView6.backgroundColor = .clear
        imageView6.image = nil
        imageView6.layer.cornerRadius = 30
        imageView6.clipsToBounds = true
        imageScroll.addSubview(imageView6)
        
        
        
        uploadButton.frame = CGRect(x: view.frame.width / 2 - 190, y: 920, width: 380, height: 80)
        uploadButton.titleLabel?.font = UIFont(name: "Futura Medium", size: 20)
        uploadButton.setTitle("Upload", for: UIControl.State.normal)
        uploadButton.layer.cornerRadius = 40
        uploadButton.clipsToBounds = true
        uploadButton.addTarget(self, action: #selector(uploadButtonPressed), for: UIControl.Event.touchDown)
        scrollView.addSubview(uploadButton)

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descField.textColor == .lightGray {
            descField.textColor = .black
            descField.text =  ""
        }
    }
    
    
    @objc func addImageButtonPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if imageView1.image == nil {
            imageView1.image = info[.originalImage] as? UIImage
            imagePlaceholder.isHidden = true
        } else if imageView2.image == nil {
            imageView2.image = info[.originalImage] as? UIImage
        } else if imageView3.image == nil {
            imageView3.image = info[.originalImage] as? UIImage
        } else if imageView4.image == nil {
            imageView4.image = info[.originalImage] as? UIImage
        } else if imageView5.image == nil {
            imageView5.image = info[.originalImage] as? UIImage
        } else if imageView6.image == nil {
            imageView6.image = info[.originalImage] as? UIImage
        } else {
            let alert = UIAlertController(title: "Error", message: "You can add six images", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        dismiss(animated: true)
    }
    
    
    
    @objc func uploadButtonPressed() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("Media")
        
        if let data = imageView1.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                    alert.addAction(okButton)
                    self.present(alert, animated: true)
                } else {
                    imageRef.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            self.imageUrlArray.append(imageUrl!)
                            print(imageUrl!)
                            print("yyyyyyyyyyyyyyyy")
                            
                            if let data = self.imageView2.image?.jpegData(compressionQuality: 0.5) {
                                let uuid = UUID().uuidString
                                let imageRef = mediaFolder.child("\(uuid).jpeg")
                                imageRef.putData(data, metadata: nil) { metadata, error in
                                    if error != nil {
                                        
                                    } else {
                                        imageRef.downloadURL { url, error in
                                            if error != nil {
                                                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                                                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                                                alert.addAction(okButton)
                                                self.present(alert, animated: true)
                                            } else {
                                                let imageUrl = url?.absoluteString
                                                self.imageUrlArray.append(imageUrl!)
                                                print(imageUrl!)
                                                print("yyyyyyyyyyyyyyyy")
                                                
                                                if let data = self.imageView3.image?.jpegData(compressionQuality: 0.5) {
                                                    let uuid = UUID().uuidString
                                                    let imageRef = mediaFolder.child("\(uuid).jpeg")
                                                    imageRef.putData(data, metadata: nil) { metadata, error in
                                                        if error != nil {
                                                            
                                                        } else {
                                                            imageRef.downloadURL { url, error in
                                                                if error != nil {
                                                                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                                                                    let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                                                                    alert.addAction(okButton)
                                                                    self.present(alert, animated: true)
                                                                } else {
                                                                    let imageUrl = url?.absoluteString
                                                                    self.imageUrlArray.append(imageUrl!)
                                                                    print(imageUrl!)
                                                                    print("yyyyyyyyyyyyyyyy")
                                                                    
                                                                    if let data = self.imageView4.image?.jpegData(compressionQuality: 0.5) {
                                                                        let uuid = UUID().uuidString
                                                                        let imageRef = mediaFolder.child("\(uuid).jpeg")
                                                                        imageRef.putData(data, metadata: nil) { metadata, error in
                                                                            if error != nil {
                                                                                
                                                                            } else {
                                                                                imageRef.downloadURL { url, error in
                                                                                    if error != nil {
                                                                                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                                                                                        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                                                                                        alert.addAction(okButton)
                                                                                        self.present(alert, animated: true)
                                                                                    } else {
                                                                                        let imageUrl = url?.absoluteString
                                                                                        self.imageUrlArray.append(imageUrl!)
                                                                                        print(imageUrl!)
                                                                                        print("yyyyyyyyyyyyyyyy")
                                                                                        
                                                                                        if let data = self.imageView5.image?.jpegData(compressionQuality: 0.5) {
                                                                                            let uuid = UUID().uuidString
                                                                                            let imageRef = mediaFolder.child("\(uuid).jpeg")
                                                                                            imageRef.putData(data, metadata: nil) { metadata, error in
                                                                                                if error != nil {
                                                                                                    
                                                                                                } else {
                                                                                                    imageRef.downloadURL { url, error in
                                                                                                        if error != nil {
                                                                                                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                                                                                                            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                                                                                                            alert.addAction(okButton)
                                                                                                            self.present(alert, animated: true)
                                                                                                        } else {
                                                                                                            let imageUrl = url?.absoluteString
                                                                                                            self.imageUrlArray.append(imageUrl!)
                                                                                                            print(imageUrl!)
                                                                                                            print("yyyyyyyyyyyyyyyy")
                                                                                                            
                                                                                                            if let data = self.imageView6.image?.jpegData(compressionQuality: 0.5) {
                                                                                                                let uuid = UUID().uuidString
                                                                                                                let imageRef = mediaFolder.child("\(uuid).jpeg")
                                                                                                                imageRef.putData(data, metadata: nil) { metadata, error in
                                                                                                                    if error != nil {
                                                                                                                        
                                                                                                                    } else {
                                                                                                                        imageRef.downloadURL { url, error in
                                                                                                                            if error != nil {
                                                                                                                                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                                                                                                                                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                                                                                                                                alert.addAction(okButton)
                                                                                                                                self.present(alert, animated: true)
                                                                                                                            } else {
                                                                                                                                let imageUrl = url?.absoluteString
                                                                                                                                self.imageUrlArray.append(imageUrl!)
                                                                                                                                print(imageUrl!)
                                                                                                                                print("yyyyyyyyyyyyyyyy")
                                                                                                                                self.uploadPost()
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            } else {
                                                                                                                self.uploadPost()
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        } else {
                                                                                            self.uploadPost()
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    } else {
                                                                        self.uploadPost()
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    self.uploadPost()
                                                }
                                            }
                                        }
                                    }
                                }
                            } else {
                                self.uploadPost()
                            }
                            
                        }
                    }
                }
            }
        } else {
            self.uploadPost()
        }
        /*
        if let data = imageView2.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID()
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    
                } else {
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                            alert.addAction(okButton)
                            self.present(alert, animated: true)
                        } else {
                            let imageUrl = url?.absoluteString
                            self.imageUrlArray.append(imageUrl!)
                            print(imageUrl!)
                            print("yyyyyyyyyyyyyyyy")
                        }
                    }
                }
            }
        }
        if let data = imageView3.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    
                } else {
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                            alert.addAction(okButton)
                            self.present(alert, animated: true)
                        } else {
                            let imageUrl = url?.absoluteString
                            self.imageUrlArray.append(imageUrl!)
                            print(imageUrl!)
                            print("yyyyyyyyyyyyyyyy")
                        }
                    }
                }
            }
        }
        if let data = imageView4.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    
                } else {
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                            alert.addAction(okButton)
                            self.present(alert, animated: true)
                        } else {
                            let imageUrl = url?.absoluteString
                            self.imageUrlArray.append(imageUrl!)
                            print(imageUrl!)
                            print("yyyyyyyyyyyyyyyy")
                        }
                    }
                }
            }
        }
        if let data = imageView5.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    
                } else {
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                            alert.addAction(okButton)
                            self.present(alert, animated: true)
                        } else {
                            let imageUrl = url?.absoluteString
                            self.imageUrlArray.append(imageUrl!)
                            print(imageUrl!)
                            print("yyyyyyyyyyyyyyyy")
                        }
                    }
                }
            }
        }
        if let data = imageView6.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpeg")
            imageRef.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    
                } else {
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                            alert.addAction(okButton)
                            self.present(alert, animated: true)
                        } else {
                            let imageUrl = url?.absoluteString
                            self.imageUrlArray.append(imageUrl!)
                            print(imageUrl!)
                            print("yyyyyyyyyyyyyyyy")
                        }
                    }
                }
            }
        }
         */
    }
    
    func uploadPost() {
        Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { Timer in
            let db = Firestore.firestore()
            db.collection("Usernames").addSnapshotListener { snapshot, error in
                if error == nil {
                    if snapshot?.isEmpty != true {
                        for doc in snapshot!.documents {
                            if let email = doc.get("email") as? String {
                                if email == Auth.auth().currentUser?.email! {
                                    if let usernameString = doc.get("username") as? String {
                                        self.username.text = usernameString
                                        
                                        let firestorePost = [
                                            "latitude": self.chosenLatitude,
                                            "longitude": self.chosenLongitude,
                                            "images": (self.imageUrlArray),
                                            "title": self.titleField.text!,
                                            "description": self.descField.text!,
                                            "postedBy": self.username.text!,
                                            "date": FieldValue.serverTimestamp()
                                        ] as [String : Any]
                                        
                                        
                                        
                                        
                                        var ref: DocumentReference? = nil
                                        ref = db.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                            if error != nil {
                                                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                                                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                                                alert.addAction(okButton)
                                                self.present(alert, animated: true)
                                            } else {
                                                self.tabBarController?.selectedIndex = 0
                                                print(self.imageUrlArray)
                                                print("x x x x x x x x x x x x x x x ")
                                            }
                                        })
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
        }
    }
    
    
    func createBackground (Frame: CGRect, View: UIView) {
        let layer2 = CAGradientLayer()
        let blurView = UIVisualEffectView()
        
        blurView.alpha = 0.85
        blurView.effect = blurEffect
        blurView.frame = Frame
        blurView.layer.cornerRadius = 40
        blurView.clipsToBounds = true
        
        scrollView.addSubview(blurView)
        
        
        layer2.frame = Frame
        layer2.colors = [UIColor(red: 0, green: 1, blue: 173/2, alpha: 0.2).cgColor, UIColor(red: 1, green: 0, blue: 157/255, alpha: 0.2).cgColor]
        layer2.startPoint = CGPoint(x: 0, y: 0)
        layer2.endPoint = CGPoint(x: 1, y: 1)
        layer2.cornerRadius = 40
        layer2.shadowOffset = CGSize(width: 0, height: 0)
        layer2.shadowOpacity = 1
        layer2.shadowColor = UIColor.white.cgColor
        layer2.shadowRadius = 20
        
        scrollView.layer.addSublayer(layer2)
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func chooseLocation (mapTouchGesture: UILongPressGestureRecognizer) {
        let touchedPoint = mapTouchGesture.location(in: mapView)
        let touchedCoordinate = mapView.convert(touchedPoint, toCoordinateFrom: mapView)
        
        chosenLatitude = touchedCoordinate.latitude
        chosenLongitude = touchedCoordinate.longitude
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchedCoordinate
        self.mapView.addAnnotation(annotation)
        
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation{
                return nil
            }
            
            let reuseId = "myAnnonation"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
            
            if pinView == nil {
                pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
                
            } else {
                pinView?.annotation = annotation
                
            }
            return pinView
        }
   
    


}

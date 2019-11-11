//
//  SharePhotoController.swift
//  7erfety App
//
//  Created by AHMED on 7/14/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController{
  
  var selectedImage: UIImage? {
    didSet{
      self.imageView.image = selectedImage
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
    
     navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
    
    setupImage()
  }
  
  let imageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .red
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()

  fileprivate func setupImage(){
    let containnerView = UIView()
    containnerView.backgroundColor = .white

    view.addSubview(containnerView)
    containnerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)

    containnerView.addSubview(imageView)
    imageView.anchor(top: containnerView.topAnchor, left: containnerView.leftAnchor, bottom: containnerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
  }
  
  @objc func handleShare(){
    guard let image = selectedImage else { return }
    
    guard let uploadData = image.jpegData(compressionQuality: 0.5) else { return }
    
    let fileName = NSUUID().uuidString
    
    let storageRef = Storage.storage().reference().child("myImage").child(fileName)
    
    storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
      
      if err != nil {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        print(err!)
        return
      }
      
      storageRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
          print("an error occurred!")
          
          return
        }
        
        let imageUrl = downloadURL.absoluteString
        
        print("Successfully uploaded image", imageUrl)
        
        self.saveToDatabaseWithImageURL(imagUrl: imageUrl)
    }
    
  }
}
  
  fileprivate func saveToDatabaseWithImageURL(imagUrl: String){
    guard let postImage = selectedImage else { return }

    guard let uid = Auth.auth().currentUser?.uid else { return }

    let userPostRef = Database.database().reference().child("myImage").child(uid)
    let ref = userPostRef.childByAutoId()
    let values = ["imageUrl" : imagUrl, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]

    ref.updateChildValues(values) { (err, ref) in
      if let err = err {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        print("Failed to save post to DB", err)
      }

      print("Successfully saved post to DB")
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
  
}

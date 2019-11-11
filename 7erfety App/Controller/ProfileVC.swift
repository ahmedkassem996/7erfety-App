//
//  ProfileVC.swift
//  7erfety App
//
//  Created by AHMED on 7/9/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

protocol HomeRequestCellDelegate {
  func didTapRequest()
}

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Alertable {
  
  var delegate: HomeRequestCellDelegate?

  @IBOutlet weak var userProfileImage: RoundImageView!
  @IBOutlet weak var usernameLbl: UILabel!
  @IBOutlet weak var userEmailLbl: UILabel!
  @IBOutlet weak var craftsTypeLbl: UILabel!
  @IBOutlet weak var stackCraftsType: UIStackView!
  @IBOutlet weak var saveImageBtn: UIButton!
  @IBOutlet weak var editViewProfileImge: UIView!
  @IBOutlet weak var discardImageBtn: UIButton!
  @IBOutlet weak var changeBtnWasPressed: RoundedShadowButton!
  @IBOutlet weak var phoneLbl: UILabel!
  @IBOutlet weak var userKindLbl: UILabel!
  @IBOutlet weak var userAgeLbl: UILabel!
  @IBOutlet weak var craftsFeedback: UIButton!
  @IBOutlet weak var craftsRequest: UIButton!
  
  var craftsId: String?
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    self.userProfileImage.setNeedsDisplay()
    
    setupInfoUser()
    
    observeUsersAndCraftsmen()
  }
  
  func observeUsersAndCraftsmen(){
    DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
      if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
        for snap in snapshot{
          if snap.key == Auth.auth().currentUser?.uid{
            self.stackCraftsType.isHidden = true
            self.craftsRequest.isHidden = true
            self.craftsFeedback.isHidden = true
          }
        }
      }
    }
    
    DataService.instance.REF_CRAFTSMEN.observeSingleEvent(of: .value) { (snapshot) in
      if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
        for snap in snapshot{
          if snap.key == Auth.auth().currentUser?.uid{
            self.stackCraftsType.isHidden = false
            self.craftsRequest.isHidden = false
            self.craftsFeedback.isHidden = false
          }
        }
      }
    }
  }
  
  fileprivate func setupInfoUser(){
    if Auth.auth().currentUser == nil{
      userEmailLbl.text = ""
      craftsTypeLbl.text = ""
      userProfileImage.backgroundColor = .lightGray
      userAgeLbl.isHidden = true
      phoneLbl.isHidden = true
      userKindLbl.isHidden = true
      
    }else{
      userEmailLbl.text = Auth.auth().currentUser?.email
      userAgeLbl.isHidden = false
      phoneLbl.isHidden = false
      userKindLbl.isHidden = false
      setupProfileImage()
    }
  }
  
  fileprivate func setupProfileImage(){
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("craftsmen").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      guard let profileImageUrl = dictionary["profileImageUrl"] as? String else { return }
      
      guard let username = dictionary["username"] as? String else { return }
      
      guard let craftsType = dictionary["craftsmenWork"] as? String else { return }
      
      guard let url = URL(string: profileImageUrl) else { return }
      URLSession.shared.dataTask(with: url) { (data, response, err) in
        if let err = err{
          print("Failed :", err)
          return
        }
        
        guard let data = data else { return }
        let image = UIImage(data: data)
        
        DispatchQueue.main.async {
          self.userProfileImage.image = image
          self.usernameLbl.text = username
          self.craftsTypeLbl.text = craftsType
        }
        
        }.resume()
      
    }) { (err) in
      print("Failed to fetch user:", err)
    }
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
      userProfileImage.image = editedImage
    }else if let chosenImage = info[.originalImage] as? UIImage {
      userProfileImage.image = chosenImage
    } else{
      print("Something went wrong")
    }
    
    userProfileImage.layer.cornerRadius = userProfileImage.frame.width / 2
    userProfileImage.layer.masksToBounds = true
    userProfileImage.layer.borderColor = UIColor.black.cgColor
    userProfileImage.layer.borderWidth = 1
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func changeImageBtnWasPressed(_ sender: Any) {
    if Auth.auth().currentUser == nil{
      self.showAlert(PLEASE_LOGIN)
    }else{
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      imagePickerController.allowsEditing = true
      present(imagePickerController, animated: true, completion: nil)
      
      self.editViewProfileImge.isHidden = false
      self.saveImageBtn.isHidden = false
      self.discardImageBtn.isHidden = false
    }
  }
  
  @IBAction func saveUpdatedImageWithFirebase(_ sender: Any) {
    updateProfileImage()
    dismiss(animated: true, completion: nil)
  }
  
  fileprivate func updateProfileImage(){
    
    guard let image = self.userProfileImage.image else { return }
    guard let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
    
    let fileName = NSUUID().uuidString
    
    let storageRef = Storage.storage().reference().child("profile_image").child(fileName)
    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, err) in
      
      if let err = err{
        print("Failed to upload profile image", err)
        return
      }
      
      storageRef.downloadURL { (url, error) in
        guard let downloadURL = url else {
          print("an error occurred!")
          
          return
        }
        
        print("Successfully uploaded profile image")
        
        let profileImageUrl = downloadURL.absoluteString
        
        self.observeUdatedPassengersAndCraftsmen(imageUrl: profileImageUrl)
        
      }
    })
  }
  
  func observeUdatedPassengersAndCraftsmen(imageUrl: String){
    DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
      if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
        for snap in snapshot{
          if snap.key == Auth.auth().currentUser?.uid{
            DataService.instance.REF_CRAFTSMEN.child((Auth.auth().currentUser?.uid)!).updateChildValues(["profileImageUrl": imageUrl])
          }
        }
      }
    }
    
    DataService.instance.REF_CRAFTSMEN.observeSingleEvent(of: .value) { (snapshot) in
      if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
        for snap in snapshot{
          if snap.key == Auth.auth().currentUser?.uid{
            DataService.instance.REF_CRAFTSMEN.child((Auth.auth().currentUser?.uid)!).updateChildValues(["profileImageUrl": imageUrl])
          }
        }
      }
    }
  }
  
  @IBAction func listRequestBtnWasPressed(_ sender: Any) {
    print("Trying to show requests...")
    
    let layout = UICollectionViewFlowLayout()
    let requestController = RequestController(collectionViewLayout: layout)
    let navController = UINavigationController(rootViewController: requestController)
    
    present(navController, animated: true, completion: nil)
  }
  
  @IBAction func discardImage(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  

}

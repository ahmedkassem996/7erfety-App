//
//  LeftSidePanelVC.swift
//  7erfety App
//
//  Created by AHMED on 7/8/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
  
  let appDelegate = AppDelegate.getAppDelegate()
  
  let currentUserID = Auth.auth().currentUser?.uid
  
  
  var crafts: Crafts?{
    didSet{
      print(crafts?.username)
    }
  }


  @IBOutlet weak var userEmailLbl: UILabel!
  @IBOutlet weak var userAccountType: UILabel!
  @IBOutlet weak var userImageView: RoundImageView!
  @IBOutlet weak var pickupModeSwitch: UISwitch!
  @IBOutlet weak var pickupModeLbl: UILabel!
  @IBOutlet weak var loginOutBtn: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    setupProfileImage()
      
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    pickupModeSwitch.isOn = false
    pickupModeSwitch.isHidden = true
    pickupModeLbl.isHidden = true

    observePassengersAndCraftsmen()

    if Auth.auth().currentUser == nil{
      userEmailLbl.text = ""
      userAccountType.text = ""
      userImageView.isHidden = true
      loginOutBtn.setTitle("Sign UP / LOGIN", for: .normal)
    }else{
      userEmailLbl.text = Auth.auth().currentUser?.email
      userAccountType.text = ""
      userImageView.isHidden = false
      loginOutBtn.setTitle("Logout", for: .normal)
    }
  }

  func observePassengersAndCraftsmen(){
    DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
      if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
        for snap in snapshot{
          if snap.key == Auth.auth().currentUser?.uid{
            self.userAccountType.text = "USER"
          }
        }
      }
    }

    DataService.instance.REF_CRAFTSMEN.observeSingleEvent(of: .value) { (snapshot) in
      if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
        for snap in snapshot{
          if snap.key == Auth.auth().currentUser?.uid{
            self.userAccountType.text = "Craftsmen"
            self.pickupModeSwitch.isHidden = false

            let switchStatus = snap.childSnapshot(forPath: "isPickUpModeEnabled").value as! Bool
            self.pickupModeSwitch.isOn = switchStatus
            self.pickupModeLbl.isHidden = false
          }
        }
      }
    }
  }

  @IBAction func switchWasToggled(_ sender: Any) {
    if pickupModeSwitch.isOn{
      pickupModeLbl.text = "PICKUP MODE ENABLED"
      appDelegate.menuContainerVC.toggleLeftPanel()
      DataService.instance.REF_CRAFTSMEN.child((Auth.auth().currentUser?.uid)!).updateChildValues(["isPickUpModeEnabled": true])
    }else{
      pickupModeLbl.text = "PICKUP MODE DISABLED"
      appDelegate.menuContainerVC.toggleLeftPanel()
      DataService.instance.REF_CRAFTSMEN.child((Auth.auth().currentUser?.uid)!).updateChildValues(["isPickUpModeEnabled": false])
    }
  }
  @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
    if Auth.auth().currentUser == nil{
      DispatchQueue.main.async {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as? LoginVC
        self.present(loginVC!, animated: true, completion: nil)
      }
      
    }else{
      do{
        try Auth.auth().signOut()
        userEmailLbl.text = ""
        userAccountType.text = ""
        userImageView.isHidden = true
        pickupModeLbl.text = ""
        pickupModeSwitch.isHidden = true
        loginOutBtn.setTitle("Sign UP / LOGIN", for: .normal)
      }catch (let error){
        print(error)
      }
    }
  }
  
  fileprivate func setupProfileImage(){
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("craftsmen").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
  //    let craftsType = dictionary["craftsmenWork"] as? String
      
      guard let profileImageUrl = dictionary["profileImageUrl"] as? String else { return }
      
    //  self.userAccountType.text = craftsType
      
      
      guard let url = URL(string: profileImageUrl) else { return }
      URLSession.shared.dataTask(with: url) { (data, response, err) in
        if let err = err{
          print("Failed :", err)
          return
        }
        
        guard let data = data else { return }
        let image = UIImage(data: data)
        
        DispatchQueue.main.async {
          self.userImageView.image = image
        }
        
        }.resume()
      
    }) { (err) in
      print("Failed to fetch user:", err)
    }
    
  }
  
  @IBAction func offersBtnWasPressed(_ sender: Any) {
    let layout = UICollectionViewFlowLayout()
    let offersController = OffersController(collectionViewLayout: layout)
    let navController = UINavigationController(rootViewController: offersController)
    present(navController, animated: true, completion: nil)
  }
  
  
}
  


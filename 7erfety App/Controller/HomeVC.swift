//
//  HomeVC.swift
//  7erfety App
//
//  Created by AHMED on 7/7/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase
import RevealingSplashView

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  @IBOutlet weak var userImageView: RoundImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var delegate: CenterVCDelegate?
  
  let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "herfetyImage")!, iconInitialSize: CGSize(width: 150, height: 150), backgroundColor: UIColor.black)

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(revealingSplashView)
    revealingSplashView.animationType = SplashAnimationType.popAndZoomOut
    revealingSplashView.startAnimation()
    revealingSplashView.iconColor = .white
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    setupProfileImage()
    
    fetchCraftsmen()
    
  }

  @IBAction func menuBtnWasPressed(_ sender: Any) {
    delegate?.toggleLeftPanel()
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredCrafts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CraftsmenCell
    
    cell.crafts = crafts[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let crafts = filteredCrafts[indexPath.item]
    
    print(crafts.username)
    
    let craftsProfileController = ProfileVC()
    
    craftsProfileController.craftsId = crafts.uid
    
    let layout = UICollectionViewFlowLayout()
    let profileSelectorController = CraftsProfileController(collectionViewLayout: layout)
    
    profileSelectorController.craftsId = crafts.uid
    
    let navController = UINavigationController(rootViewController: profileSelectorController)
    
    present(navController, animated: true, completion: nil)
  }
  
  var filteredCrafts = [Crafts]()
  var crafts = [Crafts]()
  fileprivate func fetchCraftsmen(){
    print("fetching...")
    
    let ref = Database.database().reference().child("craftsmen")
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      
      guard let dictionaries = snapshot.value as? [String: Any] else { return }
      
      dictionaries.forEach({ (key, value) in
        
        if key == Auth.auth().currentUser?.uid{
          print("found myself, omit from list ")
          return
        }
        
        guard let craftsDictionary = value as? [String: Any] else { return }
        
        let crafts = Crafts(uid: key, dictionary: craftsDictionary)
        self.crafts.append(crafts)
      })
      
      self.crafts.sort(by: { (c1, c2) -> Bool in
        return c1.username.compare(c2.username) == .orderedAscending
      })
      
      self.filteredCrafts = self.crafts
      self.collectionView.reloadData()
      
    }) { (err) in
      print("Failed to fetch craftsmen from DB:", err)
    }
  }
  
  fileprivate func setupProfileImage(){
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("craftsmen").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      guard let profileImageUrl = dictionary["profileImageUrl"] as? String else { return }
      
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
  
}


//
//  CarpenterVC.swift
//  7erfety App
//
//  Created by AHMED on 7/22/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class CarpenterVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let cellId = "cellId"
  let headerId = "headerId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    fetchCraftsmen()
    
    fetchCrafts()
    
    setupNavigationButtons()
    
    collectionView.backgroundColor = .white
    
    collectionView.register(CraftsCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView.register(CraftsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = view.frame.width
    return CGSize(width: width, height: 100)
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! CraftsHeader
    
//    header.crafts = self.crafts
    
    return header
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 3) / 4
    return CGSize(width: width, height: width)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredCrafts.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CraftsCell
    
    cell.crafts = crafts[indexPath.item]
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
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
  
//  var filteredCrafts = [Crafts]()
//  var crafts = [Crafts]()
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
  
  var filteredCrafts = [Crafts]()
  var crafts = [Crafts]()
  fileprivate func fetchCrafts(){
    
    let ref = Database.database().reference()
    
    ref.child("craftsmen").observeSingleEvent(of: .value) { (snapshot) in
      
      for crafts in snapshot.children.allObjects as! [DataSnapshot]{
        guard let crafts = crafts.value as? [String: Any] else { return }
          if crafts["craftsmenWork"] as? String == "Carpenter"{
            
            print(crafts)
            
//            guard let dictionary = snapshot.value as? [String: Any] else { return }

            crafts.forEach({ (key, value) in

//              guard let craftsDictionary = value as? [String: Any] else { return }
              
            let crafts = Crafts(uid: key, dictionary: crafts)
              self.crafts.append(crafts)
            })

            self.filteredCrafts = self.crafts
            self.collectionView.reloadData()
            
          }
//        }
      }
    }
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
  
  fileprivate func setupNavigationButtons(){
    navigationItem.title = "CARPENTER"
    
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
  }
  
  @objc func handleCancel(){
    dismiss(animated: true, completion: nil)
  }
}

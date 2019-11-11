//
//  CraftsProfileController.swift
//  7erfety App
//
//  Created by AHMED on 7/16/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class CraftsProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
  
  let cellId = "cellId"
  let headerId = "headerId"
  
  var craftsId: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    setupNavigationButtons()
    
    collectionView.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
    
    collectionView.register(CraftsProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    
    fetchCrafts()
  //  fetchOrderedImages()
    
  } 
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = view.frame.width
    return CGSize(width: width, height: width - 80)
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! CraftsProfileHeader
    
    header.crafts = self.crafts
    
    return header

  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 3) / 4
    return CGSize(width: width, height: width)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserProfilePhotoCell
    
    cell.image = images[indexPath.item]
    
    return cell
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
  
  fileprivate func setupNavigationButtons(){
    navigationItem.title = "CraftsProfile"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Request >", style: .plain, target: self, action: #selector(handleRequest))
    navigationItem.rightBarButtonItem?.tintColor = .red
    
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
  }
  
  @objc func handleRequest(){
    
    let craft = crafts
    print(craft!.uid)
    
    let craftsProfileController = ProfileVC()
    
    craftsProfileController.craftsId = crafts!.uid
    
    let layout = UICollectionViewFlowLayout()
    let profileSelectorController = CRequestVC(collectionViewLayout: layout)
    
    profileSelectorController.craftsId = crafts!.uid
    
    let navController = UINavigationController(rootViewController: profileSelectorController)
    
    present(navController, animated: true, completion: nil)
    
//    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "CompleteRequestVC") as! CompleteRequestVC
//    present(yourVC, animated: true, completion: nil)
  }
  
  @objc func handleCancel(){
    dismiss(animated: true, completion: nil)
  }
  
  fileprivate func fetchOrderedImages(){
    guard let uid = self.crafts?.uid else { return }
    let ref = Database.database().reference().child("myImage").child(uid)
    
    ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      
      let image = Image(dictionary: dictionary)
      self.images.append(image)
      
      self.collectionView.reloadData()
    }) { (err) in
      print("Failed to fetch ordered image:", err)
    }
    
  }
  
  var images = [Image]()
  fileprivate func fetchImages(){
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let ref = Database.database().reference().child("myImage").child(uid)
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      
      guard let dictionaries = snapshot.value as? [String: Any] else { return }
      
      dictionaries.forEach({ (key, value) in
        guard let dictionary = value as? [String: Any] else { return }
        
        let image = Image(dictionary: dictionary)
        self.images.append(image)
      })
      
      self.collectionView.reloadData()
      
    }) { (err) in
      print("Failed to fetch Images")
    }
  }
  
  var crafts: Crafts?
  fileprivate func fetchCrafts(){
    
    let uid = craftsId ?? (Auth.auth().currentUser?.uid ?? "")
    
    //   guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Database.fetchCraftsmenWithUid(uid: uid) { (crafts) in
      self.crafts = crafts
      self.navigationItem.title = self.crafts?.username
      self.collectionView.reloadData()
      self.fetchOrderedImages()
    }
  }
  
 
}

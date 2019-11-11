//
//  FeaturedImagesVC.swift
//  7erfety App
//
//  Created by AHMED on 7/13/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class FeaturedImagesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      collectionView.delegate = self
      collectionView.dataSource = self
      
      collectionView.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: "cellId")
      
   //   fetchImages()
      
      fetchOrderedImages()
      
    }
  
  fileprivate func fetchOrderedImages(){
    guard let uid = Auth.auth().currentUser?.uid else { return }
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
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserProfilePhotoCell
    
    cell.image = images[indexPath.item]
    
    return cell
  }
  


  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func plusPhotoBtnWasPressed(_ sender: Any) {
    let layout = UICollectionViewFlowLayout()
    let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
    let navController = UINavigationController(rootViewController: photoSelectorController)
    present(navController, animated: true, completion: nil)
    
  }
  
  @IBAction func cameraBtnWasPressed(_ sender: Any) {
    
  }
}

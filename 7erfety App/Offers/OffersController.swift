//
//  OffersController.swift
//  7erfety App
//
//  Created by AHMED on 8/4/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class OffersController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
  
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView?.register(OffersCell.self, forCellWithReuseIdentifier: cellId)
    
//    let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
//    layout?.scrollDirection = .horizontal
//    layout?.minimumLineSpacing = 0
//    
//    collectionView?.isPrefetchingEnabled = true
    
    setupNavigationButtons()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 130, height: 130)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 15
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    
    return cell
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
  
  fileprivate func setupNavigationButtons(){
    navigationItem.title = "Offers"
    
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
  }
  
  @objc func handleCancel(){
    dismiss(animated: true, completion: nil)
  }
}

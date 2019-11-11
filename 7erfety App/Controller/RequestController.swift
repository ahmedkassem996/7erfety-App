//
//  RequestController.swift
//  7erfety App
//
//  Created by AHMED on 7/28/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import  Firebase

class RequestController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let cellId = "cellId"
  
  var crafts: Crafts?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
    
    collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
    
    collectionView.register(RequestListCell.self, forCellWithReuseIdentifier: cellId)
    
    setupNavigationButtons()
    
    fetchRequestWithCrafts()
  }
  
  var request = [Request]()
  fileprivate func fetchRequestWithCrafts(){
    let ref = Database.database().reference().child("Request")
    ref.observe(.value, with: { (snapshot) in
      
      for request in snapshot.children.allObjects as! [DataSnapshot]{
        guard let request = request.value as? [String: Any] else { return }
          if request["craftsUid"] as? String == Auth.auth().currentUser?.uid{

           print(request)

              let request = Request(dictionary: request)

              self.request.append(request)
              self.request.sort(by: { (r1, r2) -> Bool in
                r1.date.compare(r2.date) == .orderedDescending && r1.time.compare(r2.time) == .orderedDescending
              })
              self.collectionView.reloadData()
          }
      }
    }) { (err) in
      print("Failed to observe request")
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: view.frame.width, height: 250)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return request.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath ) as! RequestListCell
    
    cell.request = self.request[indexPath.row]
    
    return cell
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
  
  fileprivate func setupNavigationButtons(){
    navigationItem.title = "Request list"
    
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
  }
  
  @objc func handleCancel(){
    dismiss(animated: true, completion: nil)
  }
}

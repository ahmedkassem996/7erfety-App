//
//  SearchVC.swift
//  7erfety App
//
//  Created by AHMED on 7/10/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Firebase

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    searchBar.delegate = self
    
    collectionView.delegate = self
    
    collectionView.dataSource = self
    
    collectionView.register(UserSearchCell.self, forCellWithReuseIdentifier: "cellId")
    
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode = .onDrag
    
    fetchCraftsmen()
      
    }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchText.isEmpty {
      filteredCrafts = crafts
    } else {
      filteredCrafts = self.crafts.filter { (crafts) -> Bool in
        return crafts.username.lowercased().contains(searchText.lowercased())
      }
    }
    
    self.collectionView.reloadData()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    searchBar.isHidden = false
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    searchBar.isHidden = true
    searchBar.resignFirstResponder()
    
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredCrafts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! UserSearchCell
    
    cell.crafts = crafts[indexPath.item]
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: view.frame.width, height: 66)

  }
  
  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  
}

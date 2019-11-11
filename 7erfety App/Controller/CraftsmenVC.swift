//
//  CraftsmenVC.swift
//  7erfety App
//
//  Created by AHMED on 7/10/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

//import UIKit
//import Firebase
//
//class CraftsmenVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
//
//  @IBOutlet weak var categoryTitlLbl: UILabel!
//
//  @IBOutlet weak var craftsmenCollection: UICollectionView!
//
//  private(set) public var craftsmen = [Crafts]()
//  var category: Category!
//  var crafts: Crafts?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      craftsmenCollection.delegate = self
//      craftsmenCollection.dataSource = self
//      
//    }
//
//  func initCraftsmen(category: Category){
//    craftsmen = DataService.instance.getCraftsmen(forCategoryTitle: category.title)
//      categoryTitlLbl?.text = category.title
//
//  }
//  
//  var cWork = [CWork]()
//  fileprivate func fetchCrats(){
//    guard let craftsId = self.crafts?.id else { return }
//    let ref = Database.database().reference().child("craftsmen").child(craftsId)
//    ref.observe(.childAdded, with: { (snapshot) in
//      
//      guard let dictionary = snapshot.value as? [String: Any] else { return }
//      
//      guard let uid = dictionary["uid"] as? String else { return }
//      
//      Database.fetchCraftsmenWithUid(uid: uid, completion: { (crafts) in
//        
//        let cwork = CWork(cWork: crafts, dictionary: dictionary)
//        self.cWork.append(cwork)
//        self.craftsmenCollection.reloadData()
//        
//      })
//      
//    }) { (err) in
//      print("Failed to observe comments")
//    }
//  }
//
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return cWork.count
//  }
//
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CraftsmenCell", for: indexPath) as? CraftsmenCell{
//      cell.crafts = self.cWork[indexPath.item]
//
//      if categoryTitlLbl.text == nil{
//        categoryTitlLbl?.text = category.title
//      }
//      
//
//      return cell
//    }
//
//    return CraftsmenCell()
//
//  }
//
//  @IBAction func cancelBtnWasPressed(_ sender: Any) {
//    dismiss(animated: true, completion: nil)
//  }
//
//}

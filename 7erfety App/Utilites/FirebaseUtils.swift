//
//  FirebaseUtils.swift
//  7erfety App
//
//  Created by AHMED on 7/12/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation
import Firebase

extension Database {
  static func fetchCraftsmenWithUid(uid: String, completion: @escaping (Crafts) -> ()) {
    print("Fetching crafts with uid:", uid)
    
    Database.database().reference().child("craftsmen").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      
      print(snapshot.value ?? "")
      
      guard let craftsDictionary = snapshot.value as? [String: Any] else { return }
      
      let crafts  = Crafts(uid: uid, dictionary: craftsDictionary)
      completion(crafts)
      
    }) { (error) in
      print("Failed to fetch crafts:", error)
    }
  }
  
  static func fetchCrfatsWithCraftsType(craftsType: String, completion: @escaping (Crafts) -> ()){
    print("Fetching crafts with craftsType:", craftsType)
    
    Database.database().reference().child("craftsmen").child("craftsmenWork").observeSingleEvent(of: .value, with: { (snapshot) in
      
       print(snapshot.value ?? "")
      
       guard let craftsDictionary = snapshot.value as? [String: Any] else { return }
      
      let crafts = Crafts(uid: craftsType, dictionary: craftsDictionary)
      completion(crafts)
      
    }) { (err) in
      print("Failed to fetch crafts:", err)
    }
  }
  
}

//
//  DataService.swift
//  7erfety App
//
//  Created by AHMED on 7/9/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService{
  static let instance = DataService()
  
  private var _REF_BASE = DB_BASE
  private var _REF_USERS = DB_BASE.child("users")
  private var _REF_CRAFTSMEN = DB_BASE.child("craftsmen")
  private var _REF_WORK = DB_BASE.child("work")
  
  var REF_BASE: DatabaseReference{
    return _REF_BASE
  }
  
  var REF_USERS: DatabaseReference{
    return _REF_USERS
  }
  
  var REF_CRAFTSMEN: DatabaseReference{
    return _REF_CRAFTSMEN
  }
  
  var REF_WORK: DatabaseReference{
    return _REF_WORK
  }
  
  func fetchCraftsType(carpenterKey: String, handler: @escaping (_ status: Bool?, _ carpenterKey: String?) -> Void){
    DataService.instance.REF_CRAFTSMEN.child(carpenterKey).child("craftsmenWork").observe(.value) { (craftsStatusSnapshot) in
      if let craftsStatusSnapshot = craftsStatusSnapshot.value as? String{
        if craftsStatusSnapshot == "Carpenter"{
          DataService.instance.REF_CRAFTSMEN.observeSingleEvent(of: .value, with: { (craftsSnapshot) in
            if let craftsSnapshot = craftsSnapshot.children.allObjects as? [DataSnapshot]{
              for crafts in craftsSnapshot{
                if crafts.childSnapshot(forPath: "Carpenter").value as? String == carpenterKey{
                  handler(true, carpenterKey)
                }else{
                  return
                }
              }
            }
          })
        }else{
          handler(false, nil)
        }
      }
    }
  }

  
 
  
  func createFirebaseDBUser(uid: String, userData: Dictionary<String, Any>, isCraftsmen: Bool){
    if isCraftsmen{
      Database.database().reference().child("craftsmen").child(uid).updateChildValues(userData)
    }else if isCraftsmen == false{
      Database.database().reference().child("user").child(uid).updateChildValues(userData)
    }
  }
  
}



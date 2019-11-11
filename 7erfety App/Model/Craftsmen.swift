//
//  Product.swift
//  7erfety App
//
//  Created by AHMED on 7/9/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation

struct Crafts {
  
 // var id: String?
  
  let uid: String
  let carpenterIsOnWork: Bool
  let isPickUpModeEnabled: Bool
  let provider: String
  let username: String
  let userIsCraftsmen: Bool
  let craftsType: String
  let profileImageUrl: String
  
  init(uid: String, dictionary: [String: Any]) {
    self.uid = uid
    self.username = dictionary["username"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    self.craftsType = dictionary["craftsmenWork"] as? String ?? ""
    self.carpenterIsOnWork = dictionary["carpenterIsOnWork"] as? Bool ?? false
    self.isPickUpModeEnabled = dictionary["isPickUpModeEnabled"] as? Bool ?? false
    self.provider = dictionary["provider"] as? String ?? ""
    self.userIsCraftsmen = dictionary["userIsCraftsmen"] as? Bool ?? false
  }
  
}

struct CWork{
  
  let cWork: Crafts?
  
}


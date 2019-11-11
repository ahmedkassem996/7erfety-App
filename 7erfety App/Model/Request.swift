//
//  Request.swift
//  7erfety App
//
//  Created by AHMED on 7/28/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation

struct Request{
  
  var id: String?
  
//  let crafts: String
  
  let username: String
  let description: String
  let date: String
  let time: String
  let address: String
  let image: String
  let craftsUid: String
  
  init(dictionary: [String: Any]) {
  //  self.crafts = crafts
    self.description = dictionary["descriptionTextField"] as? String ?? ""
    self.username = dictionary["nameOrPhone"] as? String ?? ""
    self.date =  dictionary["dateLbl"] as? String ?? ""
    self.time = dictionary["timeLbl"] as? String ?? ""
    self.address = dictionary["addressTextfield"] as? String ?? ""
    self.image = dictionary["requestImageUrl"] as? String ?? ""
    self.craftsUid = dictionary["craftsUid"] as? String ?? ""
  }
}

//
//  Image.swift
//  7erfety App
//
//  Created by AHMED on 7/14/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import Foundation

struct Image {
  let imageUrl: String
  
  init(dictionary: [String: Any]) {
    self.imageUrl = dictionary["imageUrl"] as? String ?? ""
  }
}

//
//  CraftsmenCell.swift
//  7erfety App
//
//  Created by AHMED on 7/9/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class CraftsmenCell: UICollectionViewCell {
  
  var crafts: Crafts?{
    didSet{
      usernameLbl.text = crafts?.username
      
      craftsWorkLbl.text = crafts?.craftsType
      
      guard let profileImageUrl = crafts?.profileImageUrl else { return }

      photoImage.loadImage(urlString: profileImageUrl)
    }
  }

  
  @IBOutlet weak var photoImage: CustomImageView!
  @IBOutlet weak var usernameLbl: UILabel!
  @IBOutlet weak var craftsWorkLbl: UILabel!
  
}

//
//  CraftsCell.swift
//  7erfety App
//
//  Created by AHMED on 7/22/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class CraftsCell: UICollectionViewCell{
  
  var crafts: Crafts?{
    didSet{
   //   usernameLbl.text = crafts?.username
      
     // craftsWorkLbl.text = crafts?.craftsType
      
      guard let profileImageUrl = crafts?.profileImageUrl else { return }
      
      photoImageView.loadImage(urlString: profileImageUrl)
    }
  }
  
  let photoImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .lightGray
    
    addSubview(photoImageView)
    photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//
//  PhotoSelectorHeader.swift
//  7erfety App
//
//  Created by AHMED on 7/14/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
  
  let photoImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .cyan
    return iv
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(photoImageView)
    photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

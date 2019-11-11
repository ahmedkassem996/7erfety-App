//
//  CraftsHeaderCell.swift
//  7erfety App
//
//  Created by AHMED on 7/22/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class CraftsHeader: UICollectionViewCell {
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "Choose better and book now."
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .lightGray
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(label)
    label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//
//  UserSearchCell.swift
//  7erfety App
//
//  Created by AHMED on 7/15/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class UserSearchCell: UICollectionViewCell{
  
  var crafts: Crafts?{
    didSet{
      usernameLabel.text = crafts?.username
      
      craftsTypeLabel.text = crafts?.craftsType
      
      guard let profileImageUrl = crafts?.profileImageUrl else { return }
      
      profileImageView.loadImage(urlString: profileImageUrl)
    }
  }
  
  let profileImageView: CustomImageView = {
    let iv = CustomImageView()
    iv.clipsToBounds = true
    iv.backgroundColor = .red
    iv.contentMode = .scaleAspectFill
    return iv
  }()
  
  let usernameLabel: UILabel = {
    let label = UILabel()
    label.text = "Username"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let craftsTypeLabel: UILabel = {
    let label = UILabel()
    label.text = "craftsType"
    label.textColor = .red
    label.font = UIFont.boldSystemFont(ofSize: 12)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(profileImageView)
    addSubview(usernameLabel)
    addSubview(craftsTypeLabel)
    
    profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    profileImageView.layer.cornerRadius = 50 / 2
    profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    usernameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    craftsTypeLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
    
    let separatorView = UIView()
    separatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    addSubview(separatorView)
    separatorView.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

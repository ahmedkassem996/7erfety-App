//
//  CraftsProfileHeader.swift
//  7erfety App
//
//  Created by AHMED on 7/16/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import  Firebase

class CRequestHeader: UICollectionViewCell{
  
  var crafts: Crafts?{
    didSet{
      usernameLabel.text = crafts?.username
      
      craftsTypeLabel.text = crafts?.craftsType ?? ""
      
      guard let profileImageUrl = crafts?.profileImageUrl else { return }
      
      profileImageView.loadImage(urlString: profileImageUrl)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    setupView()
    
    backgroundColor = .white
  }
  
  let profileImageView: CustomImageView = {
    let imageView = CustomImageView()
    imageView.backgroundColor = .lightGray
    return imageView
  }()
  
  let usernameLabel: UILabel = {
    let label = UILabel()
    label.text = "username"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let craftsTypeLabel: UILabel = {
    let label = UILabel()
    
    let attributedText = NSMutableAttributedString(string: "Crafts Type:", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    
    attributedText.append(NSMutableAttributedString(string: " CraftsType", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
    
    label.attributedText = attributedText
    label.textColor = .black
    
    return label
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.text = "Cairo"
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  fileprivate func setupView(){
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
    profileImageView.layer.cornerRadius = 140 / 2
    profileImageView.clipsToBounds = true
    
    addSubview(usernameLabel)
    usernameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(craftsTypeLabel)
    craftsTypeLabel.anchor(top: usernameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(addressLabel)
    addressLabel.anchor(top: craftsTypeLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

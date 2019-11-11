//
//  CraftsProfileHeader.swift
//  7erfety App
//
//  Created by AHMED on 7/16/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import  Firebase

class CraftsProfileHeader: UICollectionViewCell{
  
  var crafts: Crafts?{
    didSet{
      usernameLabel.text = crafts?.username
      
      craftsTypeLabel.text = ("Crafts type: \(crafts?.craftsType ?? "") ")
      
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
  
//  let requestButton: UIButton = {
//    let button = UIButton(type: .system)
//    button.setTitle("Request Now", for: .normal)
//    button.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
//    
//    button.layer.cornerRadius = 5.0
//    button.tintColor = .white
//    button.layer.shadowRadius = 10.0
//    button.layer.shadowColor = UIColor.darkGray.cgColor
//    button.layer.shadowOpacity = 0.3
//    button.layer.shadowOffset = CGSize.zero
//    
//    button.addTarget(self, action: #selector(handleRoot), for: .touchUpInside)
//    
//    return button
//  }()
  
  @objc func handleRoot(){
    
  }
  
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
  
  let phoneLabel: UILabel = {
    let label = UILabel()
    
    let attributedText = NSMutableAttributedString(string: "Phone:", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    
    attributedText.append(NSMutableAttributedString(string: " 01094605473", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
    
    label.attributedText = attributedText
    label.textColor = .black
    
    return label
  }()
  
  let KindLabel: UILabel = {
    let label = UILabel()
    
    let attributedText = NSMutableAttributedString(string: "Kind:", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    
    attributedText.append(NSMutableAttributedString(string: " male", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
    
    label.attributedText = attributedText
    label.textColor = .black
    
    return label
  }()
  
  let AgeLabel: UILabel = {
    let label = UILabel()
    
    let attributedText = NSMutableAttributedString(string: "Age:", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    
    attributedText.append(NSMutableAttributedString(string: " 22", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
    
    label.attributedText = attributedText
    label.textColor = .black
    
    return label
  }()
  
  fileprivate func setupView(){
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
    profileImageView.layer.cornerRadius = 80 / 2
    profileImageView.clipsToBounds = true
    
//    addSubview(requestButton)
//    requestButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 120, height: 40)
    
    addSubview(usernameLabel)
    usernameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(craftsTypeLabel)
    craftsTypeLabel.anchor(top: usernameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    addSubview(phoneLabel)
    phoneLabel.anchor(top: craftsTypeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    addSubview(KindLabel)
    KindLabel.anchor(top: phoneLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

    addSubview(AgeLabel)
    AgeLabel.anchor(top: KindLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

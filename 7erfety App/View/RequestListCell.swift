//
//  RequestListCell.swift
//  7erfety App
//
//  Created by AHMED on 7/28/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class RequestListCell: UICollectionViewCell{
  
  var request: Request?{
    didSet{
      guard let request = request else { return }
      
      usernameLbl.text = ("Username or phone: " + request.username)
      descriptionLbl.text = ("Description of problem: " + request.description)
      addressLbl.text = ("Address: " + request.address)
      dateLbl.text = ("Date: " + request.date)
      timeLbl.text = ("Time: " + request.time)
      imageView.loadImage(urlString: request.image)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    initialBtn.backgroundColor = UIColor.rgb(red: 245, green: 130, blue: 12)
    
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let usernameLbl: UILabel = {
    let label = UILabel()
    label.text = "Username:..."
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let descriptionLbl: UILabel = {
    let label = UILabel()
    label.text = "Description:..."
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let dateLbl: UILabel = {
    let label = UILabel()
    label.text = "Date:..."
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let timeLbl: UILabel = {
    let label = UILabel()
    label.text = "Time:..."
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let addressLbl: UILabel = {
    let label = UILabel()
    label.text = "Address:..."
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()
  
  let imageView: CustomImageView = {
    let imageView = CustomImageView()
    imageView.backgroundColor = .lightGray
    return imageView
  }()
  
  let initialBtn: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Evaluate request", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    
    button.addTarget(self, action: #selector(handleEvaluateRequest), for: .touchUpInside)
    return button
  }()
  
  let lineSeparatorView: UIView = {
    let line = UIView()
    line.backgroundColor = UIColor.lightGray
    return line
  }()
  
  @objc func handleEvaluateRequest(){
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let yourVC = mainStoryboard.instantiateViewController(withIdentifier: "InitialRequestVC") as! InitialRequestVC
//        present(yourVC, animated: true, completion: nil)
  }
  
  func setupView(){
    addSubview(usernameLbl)
    usernameLbl.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(descriptionLbl)
    descriptionLbl.anchor(top: usernameLbl.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(dateLbl)
    dateLbl.anchor(top: descriptionLbl.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(timeLbl)
    timeLbl.anchor(top: dateLbl.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(addressLbl)
    addressLbl.anchor(top: timeLbl.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    addSubview(imageView)
    imageView.anchor(top: addressLbl.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 100, height: 70)
    
    addSubview(initialBtn)
    initialBtn.anchor(top: topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 170, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 125, height: 45)
    
    addSubview(lineSeparatorView)
    lineSeparatorView.anchor(top: imageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
  }
}

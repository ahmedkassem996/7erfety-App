//
//  RoundedShadowButton.swift
//  7erfety App
//
//  Created by AHMED on 7/9/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

  var originalSize: CGRect?
  
  func setupView(){
    originalSize = self.frame
    self.layer.cornerRadius = 5.0
    self.layer.shadowRadius = 10.0
    self.layer.shadowColor = UIColor.darkGray.cgColor
    self.layer.shadowOpacity = 0.3
    self.layer.shadowOffset = CGSize.zero
  }
  
  override func awakeFromNib() {
    setupView()
  }

}

//
//  RoundImageView.swift
//  7erfety App
//
//  Created by AHMED on 7/8/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
  
  override func awakeFromNib() {
    setUpView()
  }

  func setUpView(){
    self.layer.cornerRadius = self.frame.width / 2
    self.clipsToBounds = true
  }

}

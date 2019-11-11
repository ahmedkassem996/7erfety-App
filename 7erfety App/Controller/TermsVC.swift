//
//  TermsVC.swift
//  7erfety App
//
//  Created by AHMED on 7/23/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class TermsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
  
  @IBAction func cancelBtnWasPressed(){
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func checkBoxTapped(_ sender: UIButton) {
    
    UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
      sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }) { (success) in
      sender.isSelected = !sender.isSelected
      UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
        sender.transform = .identity
      }, completion: nil)
    }
//    if sender.isSelected {
//     sender.isSelected = false
//     } else {
//     sender.isSelected  = true
//     }
  }

}

//
//  HelpVC.swift
//  7erfety App
//
//  Created by AHMED on 7/24/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {
  
   @IBOutlet weak var topImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
      self.topImageView.image = UIImage.gif(name: "gif")
    }
  
  
  @IBAction func cancelBtnWasPressed(){
    dismiss(animated: true, completion: nil)
  }
  
}


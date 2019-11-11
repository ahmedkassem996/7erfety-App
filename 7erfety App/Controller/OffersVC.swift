//
//  OffersVC.swift
//  7erfety App
//
//  Created by AHMED on 7/14/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import WebKit

class OffersVC: UIViewController {

  @IBOutlet weak var webView: WKWebView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    let url = URL(string: "https://deals.souq.com/eg-en/")
    let request = URLRequest(url: url!)
    
    webView.load(request)
      
    }

  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

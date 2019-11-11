//
//  PaymentVC.swift
//  7erfety App
//
//  Created by AHMED on 7/29/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import Razorpay

class PaymentVC: UIViewController, RazorpayPaymentCompletionProtocol {
  
  var razorpay: Razorpay!
  
  let API_KEY = "rzp_test_1DP5mmOlF5G5ag"

    override func viewDidLoad() {
        super.viewDidLoad()
      
      razorpay = Razorpay.initWithKey(API_KEY, andDelegate: self)
    }
  
  func onPaymentError(_ code: Int32, description str: String) {
    
  }
  
  func onPaymentSuccess(_ payment_id: String) {
    
  }
  
  @IBAction func razorpayPaymentBtnWasPressed(_ sender: Any) {
    showPaymentForm()
  }
  
  func showPaymentForm(){
    let params: [String:Any] = [
      "amount" : "10000",
      "description" : "Sample Product",
      "image" : "http://www.anblik.com/wp-content/uploads/2016/04/razorpay-logo.png",
      "name" : "Public Void Geek",
      "prefill" : [
        "contact" : "01094605473",
        "email" : "test@test.com"
      ],
      "theme" : [
        "color" : "#F37254"
      ]
    ]
    razorpay.open(params)
    
  }
  
  @IBAction func cancelBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

}

//
//  PaymentController.swift
//  7erfety App
//
//  Created by AHMED on 8/5/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit
import  Razorpay

class PaymentController: UIViewController, RazorpayPaymentCompletionProtocol {

  @IBOutlet weak var errorLbl: UILabel!
  @IBOutlet weak var paidLbl: UILabel!
  
  
  var razorpay: Razorpay!
  
  let API_KEY = "rzp_test_1DP5mmOlF5G5ag"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    razorpay = Razorpay.initWithKey(API_KEY, andDelegate: self)
    
//    DispatchQueue.main.async {
//      getTopMostViewController()?.present(alertController, animated: true, completion: nil)
//    }
  }
  
//  func getTopMostViewController() -> UIViewController? {
//    var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
//
//    while let presentedViewController = topMostViewController?.presentedViewController {
//      topMostViewController = presentedViewController
//    }
//
//    return topMostViewController
//  }
  
  func onPaymentError(_ code: Int32, description str: String) {
    //Handle all the errors
    errorLbl.isHidden = false
    paidLbl.isHidden = true
  }
  
  func onPaymentSuccess(_ payment_id: String) {
    //Handle all the success work here
    errorLbl.isHidden = true
    paidLbl.isHidden = false
  }
  
  
  @IBAction func payNowBtnPressed(_ sender: Any) {
    showPaymentForm()
    
  }
  
  func showPaymentForm(){
    let params: [String:Any] = [
      "amount" : "10000",
      "description" : "Sample Product",
      "image" : "http://www.anblik.com/wp-content/uploads/2016/04/razorpay-logo.png",
      "name" : "Public Void Geek",
      "prefill" : [
        "contact" : "9797979797",
        "email" : "test@test.com"
      ],
      "theme" : [
        "color" : "#F37254"
      ]
    ]
    
      razorpay.open(params)
    
    
    
  }
  
  
  
}

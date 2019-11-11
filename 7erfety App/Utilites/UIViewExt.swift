//
//  UIViewExt.swift
//  UPER APP
//
//  Created by AHMED on 4/15/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

extension UIView{
  func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval){
    UIView.animate(withDuration: duration) {
      self.alpha = alphaValue
    }
  }
    
    func bindToKeyboard(){
      NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name:
        UIApplication.keyboardWillChangeFrameNotification
        , object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
      let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
      let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
      let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
      let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
      let deltaY = targetFrame.origin.y  - curFrame.origin.y
      
      UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
        self.frame.origin.y += deltaY
        
      },completion: {(true) in
        self.layoutIfNeeded()
      })
    }
}



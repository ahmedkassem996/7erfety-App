//
//  Alertable.swift
//  UPER APP
//
//  Created by AHMED on 4/15/1398 AP.
//  Copyright © 1398 AHMED. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(_ msg: String) {
        let alertController = UIAlertController(title: "Error:", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
  
  func showAlertMessage(_ msg: String) {
    let alertController = UIAlertController(title: "Nice:", message: msg, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(action)
    present(alertController, animated: true, completion: nil)
  }
}
